//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// DePack unit.
// Contains routines used for unpacking and extracting entries.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit DePack;

interface

uses Windows, SysUtils, Forms, Controls, Dialogs, StrUtils;

var IfExists: Integer = 0;

procedure Unpack(index: Integer; var Buffer: String);
procedure ExtractEntry(index: Integer; Path: String; OverWarning: Boolean = True);
procedure PartialExtract;

implementation

uses files, LBAPackEd1, ExtractDlg, ProgBar, Settings, Info;

Procedure Error(Code: Integer; Param: Integer = 0; Param2: String = '');
var msg: String;
begin
 Case Code of
  1:msg:='Directory "'+Param2+'" could not be created.';
  else msg:='Unknown error.';
 end;
 If ProgBarForm.Visible then ProgBarForm.Close;
 Screen.Cursor:=crArrow;
 MessageBox(Form1.handle,PChar(Format('Error #%d: '+msg,[code])),'LBA Package Editor',MB_ICONERROR+MB_OK);
 Abort;
end;

procedure Unpack(index: Integer; var Buffer: String);
var a: Integer;
    b, d, f, g: Byte;
    e: Word;
begin
 If IsBlank(index) then Exit;
 If Entries[index].Comp>2 then Entries[index].Comp:=0;
 If Entries[index].Comp=0 then begin Buffer:=Entries[index].Data; Exit; end;
 Buffer:='';
 a:=1;
 repeat
  b:=Byte(Entries[index].Data[a]);
  for d:=0 to 7 do begin
   inc(a);
   if (b and (1 shl d))<>0 then
    Buffer:=Buffer+Entries[index].Data[a]
   else begin
    e:=Byte(Entries[index].Data[a])*256+Byte(Entries[index].Data[a+1]);
    f:=((e shr 8) and $000f)+Entries[index].Comp+1; //tutaj mamy d³ugoœæ do skopiowania
    e:=((e shl 4) and $0ff0)+((e shr 12) and $000f);  //tutaj mamy adres od koñca bufora
    for g:=1 to f do
     Buffer:=Buffer+Buffer[Length(Buffer)-e];
    Inc(a);
   end;
   If a>=Length(Entries[index].Data) then Break;
  end;
  Inc(a);
 until a>=Length(Entries[index].Data);
 SetLength(Buffer,Entries[index].RlSize);
end;

procedure ExtractEntry(index: Integer; Path: String; OverWarning: Boolean = True);
var Buffer: String;
    f: File;
    ExtractAllowed: Boolean;
begin
 If IsBlank(index) then Exit;

 ExtractAllowed:=True;
 If OverWarning and FileExists(Path) then begin
  If IfExists=0 then
   case MessageDlg('File "'+ExtractFileName(Path)+'" already exists. Overwrite it?',mtConfirmation,[mbYes,mbYesToAll,mbNo,mbNoToAll,mbCancel],0)
    of
     mrYes: ExtractAllowed:=True;
     mrNo: ExtractAllowed:=False;
     mrCancel: begin
                ProgBarForm.Close;
                Abort;
               end;
     mrYesToAll: IfExists:=1;
     mrNoToAll: IfExists:=2;
    end;
  case IfExists of
   1: ExtractAllowed:=True;
   2: ExtractAllowed:=False;
  end;
 end;

 If ExtractAllowed then begin
  Unpack(index,Buffer);
  If (LowerCase(ExtractFileExt(Form1.InLabel.Caption))='.vox') or
     AnsiContainsText('flasamp',ExtractFileName(Form1.InLabel.Caption)) then
   If Copy(Buffer,2,18)='reative Voice File' then
    Buffer[1]:='C'
   else if (Copy(Buffer,2,3)='IFF') and (Copy(Buffer,9,4)='WAVE') then
    Buffer[1]:='R';
  AssignFile(f,Path);
  try
   Rewrite(f,1);
   BlockWrite(f,Buffer[1],Length(Buffer));
  except
   MessageBox(Form1.Handle,PChar('The file '+Path+' could not be overwritten.'),'LBA Package Editor',MB_ICONERROR+MB_OK);
  end;
  try
   CloseFile(f);
  except
  end;
 end;
end;

procedure PartialExtract;
var a: Integer;
    ext, buf: String;
begin
 With fExtract do begin
  ShowModal;
  If ModalResult=mrOK then begin
   eDir.Text:=IncludeTrailingPathDelimiter(eDir.Text);
   LastReDir:=eDir.Text;
   If not DirectoryExists(eDir.Text) then
    If not CreateDir(eDir.Text) then Error(1,0,eDir.Text);

   If rbCustom.Checked then MakeRangeList;
   ProgBarForm.ShowSpecial('Extracting...',False,True,0,FCount-1);
   for a:=0 to FCount-1 do begin
    If IsBlank(a) then Continue;
    If IsRep(a) and cbSkipRep.Checked then Continue;
    If (rgButOnly.ItemIndex=0)
    or ((rgButOnly.ItemIndex=1) and Odd(a))
    or ((rgButOnly.ItemIndex=2) and not Odd(a)) then
     if IsOnTheList(a+1,a) then begin
      ProgBarForm.UpdateLabel('Extracting...');
      if rExt0.Checked then
       ext:=Extensions[Entries[a].ExtIndex]
      else if rExt1.Checked then
       ext:=Extensions[cExt.ItemIndex]
      else
       ext:=eExt.Text;
      buf:=eName.Text+GetExtractedEnding(FindRow(a),cbIncInfo.Checked);
      If Length(buf)>255 then SetLength(buf,255);
      ExtractEntry(a,eDir.Text+buf+'.'+ext);
     end
     else
      ProgBarForm.UpdateLabel('Skipping...');
    If (a mod 10)=0 then begin
     ProgBarForm.UpdateBar(a);
     If IntReq then begin
      ProgBarForm.Close;
      Exit;
     end;
    end;
   end;
   ProgBarForm.Close;
   IfExists:=0;
   Form1.Status1.Panels[1].Text:='Entries succesfully extracted.';
   Beep;
  end;
 end;
end;

end.
