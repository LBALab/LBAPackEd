//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// Files unit.
// Contains package opening/saving/displaying routines.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit files;

interface

uses SysUtils, Dialogs, Forms, Controls, Windows, ProgBar, IniFiles, Math, ShellApi,
     FileCtrl, Classes;

var
 f: File;
 tf: TextFile;
 InLoaded: Boolean = false;
 Displayed: Boolean = False;
 FCount: Integer;
 Norm, Hidden, Rep, Blank: Integer;
 PrLoaded: Boolean = false;
 PrPath: String;
 LastProjectPath: String;
 PackPath: String;
 FilesBuffered: Boolean = False;

 Entries: array of record
  Offset: DWORD;
  CpSize: DWORD;
  RlSize: DWORD;
  Comp: WORD;
  FType: Integer; {-3=hidden, -2=blank, -1=normal, >-1=repeated}
  ExtIndex: Byte;
  Replace: String;
  Data: string;
 end;

 Buffers: array of record
  Name: String;
  Size: Integer;
  Data: String;
 end;

 OpOffsets: array of record
  D: DWORD;
  T: Integer;
 end;

 DispMap: array of Integer;

function GetLongName(ShortName: String): String;
Function MinPath(Path: String): String;
Procedure MinimizePaths;
procedure OpenPack(Path: String; Display: Boolean = True);
Procedure DisplayStruct;
procedure UnloadPack;
Procedure SavePack(Path: String);
procedure SaveProject(path: String);
procedure OpenProject(path: String);
procedure OpenParam(path: string);
procedure BufferFiles;

implementation

Uses LBAPackEd1, Settings, ExtractDlg, Info, Grids, Tools, Hint;

function GetLongName(ShortName: String): String;
var sr: TSearchRec;
begin
 Result:='';
 If {(pos('\\', ShortName)+pos('*', ShortName)+pos('?', ShortName)<>0)
 or} not FileExists(ShortName) then
  Result:=ShortName
 else begin
  While FindFirst(ShortName,faAnyFile,sr)=0 do begin
   Result:='\'+sr.Name+Result;
   SysUtils.FindClose(sr);
   ShortName:=ExtractFileDir(ShortName);
   If Length(ShortName)<=2 then Break;
  end;
  Result:=ExtractFileDrive(ShortName)+Result;
 end;
end;

Function MinPath(Path: String): String;
begin
 Result:=MinimizeName(Path,Form1.FileList.Canvas,Form1.FileList.ColWidths[8]-4);
end;

Procedure MinimizePaths;
var a: Integer;
begin
 If not InLoaded then Exit;
 With Form1.FileList do
  for a:=1 to RowCount-1 do
   If (IsNorm(DispMap[a]) or IsHidden(DispMap[a]) or IsRep(DispMap[a]))
   and (Copy(Entries[DispMap[a]].Replace,1,1)<>'>') then
    Cells[8,a]:=MinimizeName(Entries[DispMap[a]].Replace,Canvas,ColWidths[8]-4);
end;

Procedure UpdatePanels;
begin
 With Form1 do begin
  InfAll.Caption:='Total number of entries: '+IntToStr(FCount);
  InfReal.Caption:='Normal: '+IntToStr(Norm);
  InfHidden.Caption:='Hidden: '+IntToStr(Hidden);
  InfRep.Caption:='Repeated: '+IntToStr(Rep);
  InfBlank.Caption:='Blank: '+IntToStr(Blank);
 end;
end;

Procedure Error(FileName: String; Code: Integer; Param: Integer = 0);
var msg, offset: String;
begin
 offset:=IntToStr(Param)+' (Hex: '+IntToHex(Param,0)+').';
 Case Code of
  1:msg:='Last offset does not match file size.';
  2:msg:='File doesn''t exist.';
  3:msg:='Unexpected end of file.';
  4:msg:='Erroneous data at offset '+offset;
  5:msg:='Invalid entry size information at offset '+offset;
  6:msg:='Invalid compression information at offset '+offset;
  7:msg:='Erroneous data at line '+IntToStr(Param)+'.';
  8:msg:='Unknown project/script file extension.';
  9:msg:='Unknown package file extension.'
  else msg:='Unknown error.';
 end;
 If ProgBarForm.Visible then ProgBarForm.Close;
 Screen.Cursor:=crArrow;
 MessageBox(Form1.handle,PChar('File "'+FileName+'" is incorrect or broken!'#13#13'During opening the following problem occured:'#13+'#'+IntToStr(code)+': '+msg),'LBA Package Editor',MB_ICONERROR+MB_OK);
 try     //¿eby nie by³o b³êdu jeœli plik nie jest otwarty
  CloseFile(f);
  CloseFile(tf);
 except
 end;
 Abort;
end;

Procedure Interrupt;
begin
 MessageBox(Form1.Handle,'Interrupted by user','LBA Package Editor',MB_ICONINFORMATION+MB_OK);
 If ProgBarForm.Visible then ProgBarForm.Close;
 Screen.Cursor:=crArrow;
 SetLength(OpOffsets,0);
 try
  CloseFile(f);
 except
 end;
 Abort;
end;

Function FindNextOffset(current: Integer): Integer;
var a: Integer;
begin
 for a:=current+1 to Length(OpOffsets)-2 do
  If OpOffsets[a].T=-1 then begin
   Result:=a;
   Exit;
  end;
 Result:=Length(OpOffsets)-1;
end;

procedure OpenPack(Path: String; Display: Boolean = True);
var a, b, c, Size, test: Integer;
    fs: ShortString;
    Buffer: DWORD;
    buf: String;
begin
 path:=GetLongName(path);
 fs:=LowerCase(ExtractFileExt(Path));
 If (fs<>'.hqr') and (fs<>'.ile') and (fs<>'.obl') and (fs<>'.vox') then Error(Path,9);
 If not FileExists(Path) then Error(Path,2);
 InLoaded:=False;
 Displayed:=False;
 AssignFile(f,Path);
 FileMode:=fmOpenRead;
 Reset(f,1);
 Size:=FileSize(f);
 Screen.Cursor:=crHourGlass;
 rep:=0; blank:=0; hidden:=0;
 SetLength(OpOffsets,1);
 {$I-}
 BlockRead(f,OpOffsets[0].D,4,test);
  If test<>4 then Error(Path,3);
  If (OpOffsets[0].D>Size) or (OpOffsets[0].D=0) then Error(Path,4,0);
 OpOffsets[0].T:=-1;  //first entry is always normal
 SetLength(OpOffsets,OpOffsets[0].D div 4);
 for a:=1 to Length(OpOffsets)-1 do begin
  BlockRead(f,OpOffsets[a].D,4,test);
   If test<>4 then Error(Path,3);
  OpOffsets[a].T:=-1;
  If OpOffsets[a].D=0 then begin
   OpOffsets[a].T:=-2;
   Inc(Blank);
  end
  else
   For b:=0 to a-1 do
    If OpOffsets[a].D=OpOffsets[b].D then begin
     OpOffsets[a].T:=b;
     Inc(Rep);
     Break;
    end;
 end;
 If Size<>OpOffsets[Length(OpOffsets)-1].D then begin
  If not fSettings.cbIgnoreLast.Checked then begin
   If (MessageBox(Form1.Handle,'Last offset value differs from the file size. The file may be broken.'#13'Do you want to load it anyway?','LBA Package Editor',MB_ICONQUESTION+MB_YESNO)<>ID_YES)
   then begin
    CloseFile(f);
    Screen.Cursor:=crArrow;
    Abort;
   end;
  end
  else
   Error(Path,1);
 end;

 //FCount:=a-1;

 Screen.Cursor:=crArrow;
 ProgBarForm.ShowSpecial('Loading file...',False,True,0,a);
 SetLength(Entries,Length(OpOffsets));
 b:=0;
 For a:=0 to Length(OpOffsets)-2 do begin
  If OpOffsets[a].T=-1 then begin
   Buffer:=OpOffsets[a].D;
   repeat
    If Length(Entries)<b+1 then SetLength(Entries,b+1);
    If Buffer=OpOffsets[a].D then Entries[b].FType:=-1
    else begin Entries[b].FType:=-3; Inc(Hidden); end;
    Seek(f,Buffer);
    Entries[b].Offset:=Buffer;
    BlockRead(f,Entries[b].RlSize,4,test);
     If test<>4 then Error(Path,3);
    BlockRead(f,Entries[b].CpSize,4,test);
     If test<>4 then Error(Path,3);
     //If Entries[b].CpSize>Entries[b].RlSize then Error(Path,5,Entries[b].Offset);
    BlockRead(f,Entries[b].Comp,2,test);
     If test<>2 then Error(Path,3);
     If (Entries[b].Comp<0) or (Entries[b].Comp>2) then Error(Path,6,Entries[b].Offset+8);

    SetLength(Entries[b].Data,Entries[b].CpSize);
    BlockRead(f,Entries[b].Data[1],Entries[b].CpSize,test);
     If test<>Entries[b].CpSize then Error(Path,3);

    Inc(Buffer,Entries[b].CpSize+10);

    Inc(b);
    c:=FindNextOffset(a);
   until Buffer>=OpOffsets[c].D;
   If Buffer<>OpOffsets[c].D then Error(Path,5,OpOffsets[a].D);
  end
  else begin
   If Length(Entries)<b+1 then SetLength(Entries,b+1);
   if OpOffsets[a].T>-1 then begin
    Entries[b].Offset:=OpOffsets[a].D;
    Entries[b].CpSize:=Entries[OpOffsets[a].T].CpSize;
    Entries[b].RlSize:=Entries[OpOffsets[a].T].RlSize;
    Entries[b].Comp:=Entries[OpOffsets[a].T].Comp;
    Entries[b].Data:=Entries[OpOffsets[a].T].Data;
   end
   else begin
    Entries[b].CpSize:=0;
    Entries[b].RlSize:=0;
   end;
   Entries[b].FType:=OpOffsets[a].T;
   Inc(b);
  end;

  If (a mod 10)=0 then begin
   ProgBarForm.UpdateBar(a);
   If IntReq then Interrupt;
  end;
 end;
 {$I+}
 FCount:=b;
 SetLength(Entries,b+1);
 Entries[FCount].Offset:=OpOffsets[Length(OpOffsets)-1].D;
 SetLength(OpOffsets,0);
 ProgBarForm.Close;
 CloseFile(f);
 Norm:=FCount-Rep-Blank-Hidden;
 UpdatePanels;
 SetCaption(Form1.InLabel,path);
 AddToRecent(Path);
 PackPath:=Path;
 LoadInfoFile;
 SetCaption(Form1.lb_filedesc,EntryInfo[0]);
 Form1.Caption:='LBA Package Editor - '+ExtractFileName(PackPath);
 Application.Title:=Form1.Caption;
 InLoaded:=True;
 for a:=0 to Length(Entries)-1 do Entries[a].ExtIndex:=GetExt(a);
 If fSettings.cbSameFile.Checked then Form1.bSameClick(Form1);
 Form1.Status1.Panels[0].Text:='File size: '+IntToStr(Entries[FCount].Offset);
 If Display then DisplayStruct;
 buf:=ExtractFileName(Form1.InLabel.Caption);
 fExtract.eName.Text:=Copy(buf,1,Length(Buf)-4);
 Form1.Status1.Panels[1].Text:='Package succesfully loaded.';
 SysUtils.Beep;
end;

Procedure DisplayStruct;
var a, b, NHRCount, BlankCount: Integer;
    Entrepl: Boolean;
begin
 Displayed:=False;
 If not InLoaded then Exit;
 ProgBarForm.ShowSpecial('Analyzing data...',False,True,0,FCount);
 with Form1.FileList do begin
  Visible:=False;
  RowCount:=1;
  SetLength(DispMap,FCount+1);
  Entrepl:=False;
  NHRCount:=1;
  BlankCount:=0;
  for a:=0 to FCount-1 do begin
   case Entries[a].FType of
    -1:begin
        RowCount:=RowCount+1;
        DispMap[RowCount-1]:=a;
        Cells[5,RowCount-1]:='Normal';
        Cells[7,RowCount-1]:=EntryInfo[NHRCount];
        If Copy(Entries[a].Replace,1,1)='>' then Entrepl:=True;
       end;
    -3:begin
        RowCount:=RowCount+1;
        DispMap[RowCount-1]:=a;
        Cells[5,RowCount-1]:='Hidden';
        Cells[7,RowCount-1]:=EntryInfo[NHRCount];
        //If Copy(Entries[a].Replace,1,1)='>' then Entrepl:=True;
       end;
    -2:begin
        If Form1.aBlank.Checked then begin
         Inc(BlankCount);
         If Form1.aCompact.Checked and (BlankCount<>1) then begin
          Cells[0,RowCount-1]:=Format('%d...%d',[a-BlankCount+2,a+1]);
          Cells[5,RowCount-1]:=Format('Blank (%d entries)',[BlankCount]);
         end
         else begin
          RowCount:=RowCount+1;
          for b:=1 to 8 do Cells[b,RowCount-1]:='';
          Cells[0,RowCount-1]:=IntToStr(a+1);
          Cells[5,RowCount-1]:='Blank';
          DispMap[RowCount-1]:=a;
         end;
        end
        else Continue;
       end;
    else begin
     RowCount:=RowCount+1;
     DispMap[RowCount-1]:=a;
     Cells[5,RowCount-1]:='R: '+Cells[0,FindRow(Entries[a].FType)];
     Cells[7,RowCount-1]:=EntryInfo[NHRCount];
     If Copy(Entries[a].Replace,1,1)='>' then Entrepl:=True;
    end;
   end;

   If not IsBlank(a) then begin
    Inc(NHRCount);
    BlankCount:=0;
    Cells[0,RowCount-1]:=IntToStr(a+1);
    Cells[1,RowCount-1]:=IntToStr(Entries[a].Offset);
    Cells[2,RowCount-1]:=IntToStr(Entries[a].RlSize);
    Cells[3,RowCount-1]:=IntToStr(Entries[a].CpSize);
    Cells[4,RowCount-1]:=IntToStr(Entries[a].Comp);
    Cells[6,RowCount-1]:=GetDispExt(Entries[a].ExtIndex);
   end;

   If (a mod 10)=0 then begin
    ProgBarForm.UpdateBar(a);
    If IntReq then Break;
   end;
  end;
  MinimizePaths;
  if RowCount>1 then FixedRows:=1;
  SetLength(DispMap,RowCount);
  SetLength(SelectedRows,0);
  SetLength(SelectedRows,RowCount);

  SelectedRows[1]:=True;
  SelectCount:=1;
  Form1.Label5.Caption:='Selected: 1';
  If Entrepl then
   for a:=0 to FCount-1 do
    If Copy(Entries[a].Replace,1,1)='>' then
     Cells[8,FindRow(a)]:='>'+Cells[0,FindRow(StrToInt(Copy(Entries[a].Replace,2,Length(Entries[a].Replace)-1)))];
  Visible:=True;
 end;
 ProgBarForm.Close;
 DragAcceptFiles(Form1.FileList.Handle,True);
 Displayed:=True;
 EnableMenus(True);
 EnableIfNeeded(Form1.FileList.Selection.Top);
end;

procedure UnloadPack;
begin
 TerminateAllThreads;
 DragAcceptFiles(Form1.FileList.Handle,False);
 Form1.FileList.Visible:=False;
 Form1.InfAll.Caption:='Total number of entries:';
 Form1.InfReal.Caption:='Normal:';
 Form1.InfHidden.Caption:='Hidden:';
 Form1.InfRep.Caption:='Repeated:';
 Form1.InfBlank.Caption:='Blank:';
 SetCaption(Form1.InLabel,'>>> not specified <<<');
 SetCaption(Form1.OutLabel,'>>> not specified <<<');
 SetCaption(Form1.lb_filedesc,'...');
 Form1.Label5.Caption:='';
 Form1.Caption:='LBA Package Editor';
 Application.Title:='LBA Package Editor';
 PackPath:='';
 EnableMenus(False);
 InLoaded:=False;
 Displayed:=False;
 OutSpec:=False;
 PrLoaded:=False;
 Modified:=False;
 SetLength(Entries,0);
 SetLength(DispMap,0);
 SetLength(SelectedRows,0);
end;

function FindBuffer(path: String): Integer;
var a: Integer;
    b: String;
begin
 Result:=-1;
 b:=LowerCase(ExtractFileName(path));
 for a:=0 to Length(Buffers)-1 do
  If Buffers[a].Name=b then begin
   Result:=a;
   Exit;
  end;
end;

Procedure BufferError(path: String);
begin
 ProgBarForm.Close;
 MessageBox(Form1.Handle,PChar('LBA Package Editor raised an internal error named: "File '''+path+''' has not been buffered" and may be unstable. Please save all changes and restart the program as soon as possible.'),'LBA Package Editor',MB_ICONERROR+MB_OK);
 Abort;
end;

procedure CalcOffsets;
var a, b, c: Integer;
    Buff: DWORD;
    d: String;
begin
 buff:=(FCount-Hidden+1)*4;
 SetLength(OpOffsets,Length(Entries));
 For a:=0 to FCount do begin
  If IsNorm(a) or (a=FCount) then
   OpOffsets[a].D:=Buff
  else if IsBlank(a) then
   OpOffsets[a].D:=0
  else if IsRep(a) then
   OpOffsets[a].D:=OpOffsets[Entries[a].FType].D;

  OpOffsets[a].T:=Entries[a].FType;
  If not IsBlank(a) then begin
   c:=10+Entries[a].CpSize;
   If Entries[a].Replace<>'' then
    If Entries[a].Replace[1]<>'>' then begin
     b:=FindBuffer(Entries[a].Replace);
     If b<0 then BufferError(Entries[a].Replace);
     If Buffers[b].Size>-1 then begin
      c:=10+Buffers[b].Size;
      If IsRep(a) then begin
       OpOffsets[a].T:=-1;
       OpOffsets[a].D:=buff;
      end;
     end;
    end
    else begin
     d:=Copy(Entries[a].Replace,2,Length(Entries[a].Replace)-1);
     c:=10+Entries[StrToInt(d)].CpSize;
     If IsRep(a) then begin
      OpOffsets[a].T:=-1;
      OpOffsets[a].D:=buff;
     end; 
    end;
   If OpOffsets[a].T<0 then Inc(Buff,c);
  end;
 end;
end;

Procedure SavePack(Path: String);
var f: File;
    a, b, c, d: Integer;
    Replaced: Boolean;
begin
 c:=0;
 BufferFiles;
 If not FilesBuffered then Exit;
 CalcOffsets;
 AssignFile(f,Path);
 Rewrite(f,1);
 For a:=0 to FCount do
  If OpOffsets[a].T<>-3 then
   BlockWrite(f,OpOffsets[a].D,4);
 For a:=0 to FCount-1 do
  If (OpOffsets[a].T=-1) or (OpOffsets[a].T=-3) then begin
   Replaced:=False;
   d:=a;
   If Entries[a].Replace<>'' then
    If Entries[a].Replace[1]<>'>' then begin
     b:=FindBuffer(Entries[a].Replace);
     If b<0 then BufferError(Entries[a].Replace);
     If Buffers[b].Size>-1 then Replaced:=True;
    end
    else
     d:=StrToInt(Copy(Entries[a].Replace,2,Length(Entries[a].Replace)-1));

   If Replaced then begin
    BlockWrite(f,Buffers[b].Size,4);
    BlockWrite(f,Buffers[b].Size,4);
    BlockWrite(f,c,2);
    If LowerCase(ExtractFileExt(Form1.InLabel.Caption))='.vox' then
     if IsHidden(a+1) then Buffers[b].Data[1]:=#01
     else Buffers[b].Data[1]:=#00;
    BlockWrite(f,Buffers[b].Data[1],Buffers[b].Size);
   end
   else begin
    BlockWrite(f,Entries[d].RlSize,4);
    BlockWrite(f,Entries[d].CpSize,4);
    BlockWrite(f,Entries[d].Comp,2);
    BlockWrite(f,Entries[d].Data[1],Entries[d].CpSize);
   end;
  end;
 CloseFile(f);
 SetLength(Buffers,0);
 SetLength(OpOffsets,0);
 SysUtils.Beep;
 Form1.Status1.Panels[1].Text:='Package succesfully built.';
end;

procedure SaveProject(path: String);
var a: Integer;
begin
 ProgBarForm.ShowSpecial('Saving project...',False,False,0,FCount);
 AssignFile(tf,path);
 Rewrite(tf);
 WriteLn(tf,'This is LBA Package Editor project file. Don''t try to edit it by yourself unless you are absolutely sure what you are doing.');

 If InLoaded then
  WriteLn(tf,Form1.InLabel.Caption)
 else
  WriteLn(tf,'!none');

 If OutSpec then
  WriteLn(tf,Form1.OutLabel.Caption)
 else
  WriteLn(tf,'!none');

 WriteLn(tf,FCount);

 if InLoaded then
  for a:=0 to FCount-1 do begin
   if not IsBlank(a) then
    WriteLn(tf,Entries[a].Replace)
   else
    WriteLn(tf,'');
   if (a mod 10)=1 then ProgBarForm.UpdateBar(a-1);
  end;

 CloseFile(tf);
 ProgBarForm.Close;
 Modified:=False;
 Form1.Status1.Panels[1].Text:='Project succesfully saved.';
end;

procedure OpenProject(path: String);
var a, Count, index: Integer;
    LoadIn, LoadOut, ext: String;
    Replaces: array of String;
    inf: TIniFile;
begin
 path:=GetLongName(path);
 PrLoaded:=False;
 ext:=LowerCase(ExtractFileExt(path));
 if ext='.lpp' then begin
  AssignFile(tf,path);
  FileMode:=fmOpenRead;
  Reset(tf);
  ReadLn(tf,LoadIn);
  ReadLn(tf,LoadIn);
  ReadLn(tf,LoadOut);
  try
   ReadLn(tf,Count);
  except
   Error(path,7,5);
  end;

  ProgBarForm.ShowSpecial('Opening project...',False,False,0,Count);
  SetLength(Replaces,Count);
  for a:=0 to Count-1 do begin
   ReadLn(tf,Replaces[a]);
   Replaces[a]:=StringReplace(Replaces[a],'#','>',[]);
   if (a mod 10)=1 then ProgBarForm.UpdateBar(a-1);
  end;
  CloseFile(tf);
 end
 else if ext='.hms' then begin
  inf:=TIniFile.Create(path);
  LoadIn:=inf.ReadString('General','In','!none');
  LoadOut:=inf.ReadString('General','Out','!none');
  Count:=inf.ReadInteger('General','Count',0);
  ProgBarForm.ShowSpecial('Opening script file...',False,False,0,Count);
  for a:=0 to Count-1 do begin
   index:=inf.ReadInteger(IntToStr(a),'Index',0);
   if Length(Replaces)<Index+1 then SetLength(Replaces,Index+1);
   Replaces[Index]:=inf.ReadString(IntToStr(a),'Path','');
   if (a mod 10)=1 then ProgBarForm.UpdateBar(a-1);
  end;
  inf.Free;
 end
 else Error(path,8);
  
 ProgBarForm.Close;

 if LoadIn<>'!none' then begin
  if not FileExists(LoadIn) then
   if FileExists(ExtractFilePath(path)+ExtractFileName(LoadIn)) then
    if MessageBox(Form1.handle,'Input file has not been found. However, a file with identical name has been found in the project directory. Do you want to use this file instead?','LBA Package Editor',MB_ICONQUESTION+MB_YESNO)=ID_YES
    then begin
     LoadIn:=ExtractFilePath(path)+ExtractFileName(LoadIn);
     Modified:=True;
    end;
  OpenPack(LoadIn,False);
 end;

 if LoadOut<>'!none' then begin
  SetCaption(Form1.OutLabel,LoadOut);
  OutSpec:=True;
 end;

 If ((ext='.lpp') and (Length(Replaces)<>FCount)) or
    ((ext='.hms') and (Length(Replaces)>FCount)) then
  MessageBox(Form1.Handle,'Number of replacements in the project/script file does not match the number of entries in the input package file. It may be broken or something. Anyway, you can work with it without danger.','LBA Package Editor',MB_ICONWARNING+MB_OK);

 if InLoaded then begin
  for a:=0 to IfThen(FCount<=Length(Replaces),FCount-1,Length(Replaces)-1) do
   Entries[a].Replace:=Replaces[a];

  PrLoaded:=True;
  PrPath:=Path;
  AddToRecent(Path);
  DisplayStruct;
  Form1.Status1.Panels[1].Text:='Project succesfully opened.';
 end;
end;

procedure OpenParam(path: string);
var ext: String;
begin
 ext:=LowerCase(ExtractFileExt(path));
 If (ext='.lpp') or (ext='.hms') then
  OpenProject(path)
 else if (ext='.hqr') or (ext='.ile') or (ext='.obl') or (ext='.vox') then
  OpenPack(path)
 else
  MessageBox(Form1.Handle,'Unknown file extension!','LBA Package Editor',MB_ICONERROR+MB_OK);
end;

procedure ExitError;
begin
 try
  CloseFile(f);
 except
 end;
 ProgBarForm.Close;
 SetLength(Buffers,0);
 Abort;
end;

function NotBufferedYet(path: String): Boolean;
var a: Integer;
    b: String;
begin
 b:=LowerCase(ExtractFileName(path));
 Result:=True;
 for a:=0 to Length(Buffers)-1 do
  If Buffers[a].Name=b then begin
   Result:=False;
   Exit;
  end;
end;

procedure BufferFiles;
var a, b: Integer;
    BadFile: Boolean;
begin
 FilesBuffered:=True;
 ProgBarForm.ShowSpecial('Buffering files...',False,True,0,FCount);
 SetLength(Buffers,0);
 b:=-1;
 for a:=0 to FCount-1 do begin
  BadFile:=False;
  If (Entries[a].Replace<>'') and (Entries[a].Replace[1]<>'>') and
  (NotBufferedYet(Entries[a].Replace)) then begin
   Inc(b);
   SetLength(Buffers,b+1);
   If FileExists(Entries[a].Replace) then begin
    AssignFile(f,Entries[a].Replace);
    try
     FileMode:=fmOpenRead;
     Reset(f,1);
    except
     BadFile:=True;
     If MessageBox(Form1.Handle,PChar('File: "'+Entries[a].Replace+'" is inaccessible. Do you want to continue compilation without this file?'),'LBA Package Editor',MB_ICONWARNING+MB_YESNO)=ID_NO
     then ExitError;
    end;
   end
   else begin
    BadFile:=True;
    If MessageBox(Form1.Handle,PChar('File: "'+Entries[a].Replace+'" doesn''t exist. Do you want to continue compilation without this file?'),'LBA Package Editor',MB_ICONWARNING+MB_YESNO)=ID_NO
    then ExitError;
   end;
   Buffers[b].Name:=LowerCase(ExtractFileName(Entries[a].Replace));
   If BadFile then begin
    Buffers[b].Size:=-1;
    SetLength(Buffers[b].Data,0);
   end
   else begin
    Buffers[b].Size:=FileSize(f);
    SetLength(Buffers[b].Data,Buffers[b].Size);
    try
     BlockRead(f,Buffers[b].Data[1],Buffers[b].Size);
    except
     If MessageBox(Form1.Handle,PChar('There was an error during reading: file "'+Entries[a].Replace+'". Do you want to continue execution without this file?'),'LBA Package Editor',MB_ICONWARNING+MB_YESNO)=ID_NO
     then ExitError
     else begin
      Buffers[b].Size:=-1;
      SetLength(Buffers[b].Data,0);
     end;
    end;
    CloseFile(f);
    if (a mod 10)=1 then begin
     ProgBarForm.UpdateBar(a+1);
     If IntReq then ExitError;
    end;
   end;
  end;
 end;
 ProgBarForm.Close;
 FilesBuffered:=True;
end;

end.
