//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// ExtractDlg unit.
// Contains partial extract dialog.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit ExtractDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TfExtract = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    rbExtAll: TRadioButton;
    rbWithIndex: TRadioButton;
    eFrom: TEdit;
    eTo: TEdit;
    Label3: TLabel;
    rbCustom: TRadioButton;
    eCustom: TEdit;
    rgButOnly: TRadioGroup;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    rExt0: TRadioButton;
    rExt1: TRadioButton;
    rExt2: TRadioButton;
    cExt: TComboBoxEx;
    eExt: TEdit;
    GroupBox3: TGroupBox;
    eDir: TEdit;
    Label2: TLabel;
    bDir: TButton;
    Label6: TLabel;
    rbSelected: TRadioButton;
    cbSkipRep: TCheckBox;
    GroupBox4: TGroupBox;
    eName: TEdit;
    cbIncInfo: TCheckBox;
    lSample: TLabel;
    stName: TStaticText;
    StaticText1: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure eNameChange(Sender: TObject);
    procedure rExt0Click(Sender: TObject);
    procedure eCustomChange(Sender: TObject);
    procedure rbExtAllClick(Sender: TObject);
    procedure bDirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TRange = record
   vFrom, vTo: Integer;
  end;

var
  fExtract: TfExtract;

  zero: String;
  ListDone: Boolean = False;
  RangeList: array of TRange;

function ExpandNumber(val, count: Integer): String; overload;
function ExpandNumber(val: String; count: Integer): String; overload;
function GetNumber(val: Integer): String; overload;
function GetNumber(val: String): String; overload;
function GetExtractedName(IncName: Boolean = True; IncInfo: Boolean = False): String;
function GetExtractedEnding(ARow: Integer; IncInfo: Boolean = False): String;
function ConExtracted(Name, Ending: String; ARow: Integer): String;
function GetExtractedSel(IncName: Boolean = True; IncInfo: Boolean = False): String;
function GetExtracted(ARow: Integer): String;
procedure MakeRangeList;
function IsOnTheList(index, memindex: Integer): Boolean;

implementation

uses LBAPackEd1, files, Settings, Info, StrUtils;

{$R *.dfm}

function ExpandNumber(val, count: Integer): String; overload;
var buf, valstr: String;
begin
 valstr:=IntToStr(val);
 if Length(valstr)<count then begin
  buf:='000000000000000000';
  SetLength(buf,count-Length(valstr));
  Result:=buf+valstr;
 end
 else
  Result:=valstr;
end;

function ExpandNumber(val: String; count: Integer): String; overload;
var buf: String;
begin
 if Length(val)<count then begin
  buf:='000000000000000000';
  SetLength(buf,count-Length(val));
  Result:=buf+val;
 end
 else
  Result:=val;
end;

function GetNumber(val: Integer): String; overload;
begin
 result:=ExpandNumber(val,Length(IntToStr(FCount)));
end;

function GetNumber(val: String): String; overload;
begin
 result:=ExpandNumber(val,Length(IntToStr(FCount)));
end;

function RemoveSpecialChars(v: String): String;
var a: Integer;
begin
 for a:=1 to Length(v) do
  If (v[a]='/') or (v[a]='\') or (v[a]=':') or (v[a]='*') or (v[a]='?')
   or (v[a]='"') or (v[a]='>') or (v[a]='<') or (v[a]='|') then v[a]:='_';
 Result:=v;
end;

function GetExtractedName(IncName: Boolean = True; IncInfo: Boolean = False): String;
begin
 If not IncInfo then IncName:=True;
 If IncName then begin
  Result:=ExtractFileName(Form1.InLabel.Caption);
  Result:=LeftStr(Result,Length(Result)-4);
 end
 else Result:='';
end;

function GetExtractedEnding(ARow: Integer; IncInfo: Boolean = False): String;
begin
 Result:=GetNumber(DispMap[ARow]+1);
 If IncInfo and (Form1.FileList.Cells[7,ARow]<>'') then
  Result:=Result+'-'+RemoveSpecialChars(Form1.FileList.Cells[7,ARow]);
end;

function ConExtracted(Name, Ending: String; ARow: Integer): String;
begin
 Result:=Name+Ending;
 If Length(Result)>255 then SetLength(Result,255);
 Result:=Result+'.'+Extensions[Entries[DispMap[ARow]].ExtIndex];
end;

function GetExtractedSel(IncName: Boolean = True; IncInfo: Boolean = False): String;
begin
 Result:=ConExtracted(GetExtractedName(IncName,IncInfo),
  GetExtractedEnding(Form1.FileList.Selection.Top,IncInfo),Form1.FileList.Selection.Top);
end;

function GetExtracted(ARow: Integer): String;
begin
 Result:=ConExtracted(GetExtractedName(True,False),GetExtractedEnding(ARow,False),ARow);
end;

procedure MakeRangeList;
var a, b: Integer;
    buf, bufFrom, bufTo: String;
begin
 ListDone:=False;
 SetLength(RangeList,0);
 With fExtract.eCustom do begin
  buf:='';
  for a:=1 to Length(Text) do begin
   if ((Text[a]>='0') and (Text[a]<='9')) or (Text[a]='-') then
    buf:=buf+Text[a];
   if (Text[a]=',') or (a=Length(Text)) then begin
    SetLength(RangeList,Length(RangeList)+1);
    b:=Pos('-',buf);
    if b>0 then begin
     bufFrom:=Copy(buf,1,b-1);
     If Length(bufFrom)>8 then SetLength(bufFrom,8);
     RangeList[Length(RangeList)-1].vFrom:=StrToInt(bufFrom);
     bufTo:=Copy(buf,b+1,Length(buf)-b);
     If Length(bufTo)>8 then SetLength(bufTo,8);
     If Pos('-',bufTo)>0 then bufTo:=Copy(bufTo,1,Pos('-',bufTo)-1);
     RangeList[Length(RangeList)-1].vTo:=StrToInt(bufTo);
     buf:='';
    end
    else begin
     If Length(buf)>8 then SetLength(buf,8);
     RangeList[Length(RangeList)-1].vFrom:=StrToInt(buf);
     RangeList[Length(RangeList)-1].vTo:=StrToInt(buf);
     buf:='';
    end;
   end;
  end;
 end;
 ListDone:=True;
end;

function IsOnTheList(index, memindex: Integer): Boolean;
var a: Integer;
begin
 Result:=False;
 With fExtract do begin
  if rbExtAll.Checked then Result:=True;
  if rbSelected.Checked then
   if SelectedRows[FindRow(memindex)] then Result:=True;
  if rbWithIndex.Checked then
   if (eFrom.Text<>'') and (eTo.Text<>'')
    and (index>=StrToInt(eFrom.Text)) and (index<=StrToInt(eTo.Text)) then
    Result:=True;
  if rbCustom.Checked then
   for a:=0 to Length(RangeList)-1 do
    if (index>=RangeList[a].vFrom) and (index<=RangeList[a].vTo) then begin
     Result:=True;
     Exit;
    end;
 end;   
end;

procedure TfExtract.FormShow(Sender: TObject);
begin
 zero:=GetNumber(0);
 rExt0Click(Self);
 rbExtAllCLick(self);
end;

procedure TfExtract.FormCreate(Sender: TObject);
begin
 cExt.ItemIndex:=0;
end;

procedure TfExtract.eNameChange(Sender: TObject);
var buf: String;
    a, b: Integer;
begin
 buf:=eName.Text;
 b:=eName.SelStart;
 for a:=1 to Length(buf) do
  If (buf[a]='/') or (buf[a]='\') or (buf[a]=':') or (buf[a]='*') or (buf[a]='?')
   or (buf[a]='"') or (buf[a]='>') or (buf[a]='<') or (buf[a]='|') then
   Delete(buf,a,1);
 if eName.Text<>buf then begin
  eName.Text:=buf;
  eName.SelStart:=b-1;
 end;

 if rExt0.Checked then
  buf:='lun'
 else if rExt1.Checked then
  buf:=Extensions[cExt.ItemIndex]
 else
  buf:=eExt.Text;
 stName.Caption:=eName.Text+zero;
 If cbIncInfo.Checked then
  stName.Caption:=stName.Caption+'-Info text';
 stName.Caption:=stName.Caption+'.'+buf;
end;

procedure TfExtract.rExt0Click(Sender: TObject);
begin
 If rExt1.Checked then cExt.Enabled:=True else cExt.Enabled:=False;
 If rExt2.Checked then eExt.Enabled:=True else eExt.Enabled:=False;
 eNameChange(Self);
end;

procedure TfExtract.eCustomChange(Sender: TObject);
var a, b: Integer;
    buf: String;
begin
 buf:=(Sender as TEdit).Text;
 b:=(Sender as TEdit).SelStart;
 for a:=1 to Length(buf) do
  If ((buf[a]<>',') and (buf[a]<>'-') or ((Sender as TEdit).Name<>'eCustom'))
   and ((buf[a]<'0') or (buf[a]>'9')) then
   Delete(buf,a,1);
 if (Sender as TEdit).Text<>buf then begin
  (Sender as TEdit).Text:=buf;
  (Sender as TEdit).SelStart:=b-1;
 end; 
end;

procedure TfExtract.rbExtAllClick(Sender: TObject);
begin
 If rbWithIndex.Checked then begin
  eFrom.Enabled:=True;
  eTo.Enabled:=True;
 end
 else begin
  eFrom.Enabled:=False;
  eTo.Enabled:=False;
 end;
 If rbCustom.Checked then eCustom.Enabled:=True else eCustom.Enabled:=False;
end;

procedure TfExtract.bDirClick(Sender: TObject);
var Dir: String;
begin
 Dir:=SelectDir(fExtract.Handle,eDir.Text);
 If Dir<>'' then
  eDir.Text:=Dir;
end;

end.
