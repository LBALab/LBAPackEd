//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// Setings unit.
// Contains routines used for saving and reading program settings.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit Settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, files, Registry, ShlObj, ComObj, ExtCtrls, IniFiles,
  Menus, ActnList, ComCtrls, CompMods;

type
  TfSettings = class(TForm)
    Button1: TButton;
    Button6: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    rbOsDir0: TRadioButton;
    rbOsDir1: TRadioButton;
    rbOsDir2: TRadioButton;
    eOsDir: TEdit;
    bOsDir: TButton;
    GroupBox4: TGroupBox;
    rbIoDir0: TRadioButton;
    eIoDir: TEdit;
    rbIoDir1: TRadioButton;
    bIoDir: TButton;
    rbIoDir2: TRadioButton;
    GroupBox2: TGroupBox;
    rbReDir0: TRadioButton;
    eReDir: TEdit;
    rbReDir1: TRadioButton;
    bReDir: TButton;
    rbReDir2: TRadioButton;
    GroupBox5: TGroupBox;
    rbTmDir0: TRadioButton;
    eTmDir: TEdit;
    bTmDir: TButton;
    rbTmDir2: TRadioButton;
    rbTmDir1: TRadioButton;
    TabSheet3: TTabSheet;
    rgLMBMode: TRadioGroup;
    rgRMBMode: TRadioGroup;
    rgDblMode: TRadioGroup;
    rgNoEditMode: TRadioGroup;
    GroupBox3: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    cbLpp: TCheckBox;
    cbHqr: TCheckBox;
    cbIle: TCheckBox;
    cbObl: TCheckBox;
    cbVox: TCheckBox;
    cbOpenLast: TCheckBox;
    cbRemSize: TCheckBox;
    cbRemPos: TCheckBox;
    cbIgnoreLast: TCheckBox;
    cbDelTemp: TCheckBox;
    cbSameFile: TCheckBox;
    cbIncInfo: TCheckBox;
    cbNoIncPack: TCheckBox;
    cbColourSet: TComboBox;
    Label1: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    procedure rbOsDir2Click(Sender: TObject);
    procedure bOsDirClick(Sender: TObject);
    procedure rgDblModeClick(Sender: TObject);
    procedure cbIncInfoClick(Sender: TObject);
    procedure cbColourSetChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSettings: TfSettings;

  Folder: PItemIDList;
  WinHandle: HWND;

function SelectDir(Handle: HWND; StartDir: String;
 Title: String = 'Choose directory'): String;
procedure AddToRecent(path: String);
Procedure SetAssociations;
procedure SaveSettings;
procedure LoadSettings;
procedure RefreshDirs;
procedure ShowSettingsDialog;

implementation

uses LBAPackEd1, ExtractDlg, Tools;

{$R *.dfm}


function PathToItemIDList(const APath: WideString): PItemIDList;
var
 DesktopFolder: IShellFolder;
 SLen, FAttr: Cardinal;
begin
 Result := nil;
 if APath <> '' then
 begin
  OleCheck(SHGetDesktopFolder(DesktopFolder));
  DesktopFolder.ParseDisplayName(Application.Handle, nil, PWideChar(APath), SLen, Result, FAttr);
 end;
end;

function BrowseCallbackProc(Wnd: HWnd; Msg: UINT; LParam: LPARAM;
LpData: LPARAM): Integer; stdcall;

 procedure CenterWindow;
 var
  Rect, Rect1: TRect;
 begin
  GetWindowRect(WinHandle, Rect1);
  GetWindowRect(Wnd, Rect);
  SetWindowPos(Wnd, 0,
   ((Rect1.Right+Rect1.Left)-(Rect.Right-Rect.Left)) div 2,
   ((Rect1.Bottom+Rect1.Top)-(Rect.Bottom-Rect.Top)) div 2,
   0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
 end;

begin
 Result:=0;
 try
  If Msg = BFFM_INITIALIZED then begin
   SendMessage(Wnd, BFFM_SETSELECTION, 0, Longint(Folder));
   CenterWindow;
  end;
 except
  Application.HandleException(TObject(LParam));
 end;
end;

function SelectDir(Handle: HWND; StartDir: String;
 Title: String = 'Choose directory'): String;
var BI: TBrowseInfo;
    Buf: PChar;
    Dir, root: PItemIDList;
begin
 SelectDir:='';
 GetMem(Buf,Max_Path);
 SHGetSpecialFolderLocation(Handle,CSIDL_DESKTOP,root);
 with BI do begin
  hwndOwner:=Handle;
  pidlRoot:=root;
  pszDisplayName:=Buf;
  lpszTitle:=PChar(Title);
  ulFlags:=BIF_RETURNONLYFSDIRS+BIF_DONTGOBELOWDOMAIN+BIF_NEWDIALOGSTYLE;
  lpfn:=BrowseCallbackProc;
 end;
 WinHandle:=Handle;
 Folder:=PathToItemIDList(StartDir);
 Dir:=SHBrowseForFolder(BI);
 if Dir<>nil then begin
  SHGetPathFromIDList(Dir,Buf);
  SelectDir:=Buf;
 end;
 FreeMem(Buf);
end;

function FindAction(index: Integer): TAction;
begin
 Result:=Form1.FindComponent('a'+IntToStr(index)) as TAction;
end;

function Smaller(v1, v2: Integer): Integer;
begin
 If v1<v2 then Result:=v1 else Result:=v2;
end;

procedure AddToRecent(path: String);
var a: Integer;
    temp: TMenuItem;
begin
 path:=GetLongName(path);
 With Form1 do begin
  for a:=0 to Smaller(mRecent.Count,9)-1 do
   if AnsiSameText(path,mRecent.Items[a].Caption) then break;
  If a<mRecent.Count then begin
   temp:=mRecent.Items[a];
   mRecent.Delete(a);
   mRecent.Insert(0,temp);
   mRecent.Items[0].Caption:=path;
  end
  else begin
   mRecent.Insert(0,NewItem(path,0,False,True,aOpenRecent,0,''));
   ModMenu.UpdateMenuItem(mRecent.Items[0],False);
  end;
  mRecent.Enabled:=mRecent.Count>0;
 end;
end; 

procedure SetKey(Key, Icon, Text: String);
var Rejestr: TRegIniFile;
begin
 Rejestr:=TRegIniFile.Create('');
 Rejestr.RootKey:=HKEY_CLASSES_ROOT;
 Rejestr.WriteString('.'+Key,'','LBA_'+Key+'_package');
 Rejestr.WriteString('LBA_'+Key+'_package','',Text);
 Rejestr.WriteString('LBA_'+Key+'_package','Created by','LBA Package Editor');
 Rejestr.WriteString('LBA_'+Key+'_package\DefaultIcon','',Icon);
 Rejestr.WriteString('LBA_'+Key+'_package\shell','','open');
 Rejestr.WriteString('LBA_'+Key+'_package\shell\open\command','','"'+Application.ExeName+'" "%1"');
 Rejestr.Destroy;
end;

procedure DelKey(Key: String);
var Rejestr: TRegIniFile;
begin
 Rejestr:=TRegIniFile.Create('');
 Rejestr.RootKey:=HKEY_CLASSES_ROOT;
 If Rejestr.ReadString('LBA_'+Key+'_package','Created by','')='LBA Package Editor'
 then begin
  Rejestr.EraseSection('.'+Key);
  Rejestr.EraseSection('LBA_'+Key+'_package');
 end;
 Rejestr.Destroy;
end;

Procedure SetAssociations;
begin
 With fSettings do begin
  If cbLpp.Checked then SetKey('lpp',Application.ExeName+',1','LBA Package Editor project file')
   else DelKey('lpp');
  If cbHqr.Checked then SetKey('hqr',Application.ExeName+',2','LBA resource package')
   else DelKey('hqr');
  If cbIle.Checked then SetKey('ile',Application.ExeName+',3','LBA island package')
   else DelKey('ile');
  If cbObl.Checked then SetKey('obl',Application.ExeName+',4','LBA island object package')
   else DelKey('obl');
  If cbVox.Checked then SetKey('vox',Application.ExeName+',5','LBA speech package')
   else DelKey('vox');
 end;
end;

Function GetRadioValue(Name: String): Integer;
begin
 Result:=0;
 If (fSettings.FindComponent(name+'1') as TRadioButton).Checked then Result:=1;
 If (fSettings.FindComponent(name+'2') as TRadioButton).Checked then Result:=2;
end;

Procedure SetRadioValue(Name: String; Value: Integer);
begin
 (fSettings.FindComponent(name+IntToStr(Value)) as TRadioButton).Checked:=True;
end;

procedure SaveSettings;
var sf: TIniFile;
    a: Integer;
begin
 try
 sf:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'LBAPackEd.ini');
 With sf, Form1, fSettings do begin
  WriteBool('Options','DispBlank',aBlank.Checked);
  WriteBool('Options','CompBlank',aCompact.Checked);
  WriteInteger('Options','OsDirMode',GetRadioValue('rbOsDir'));
  WriteString('Options','OsDirPath',eOsDir.Text);
  WriteString('Options','LastOsDir',LastOsDir);
  WriteInteger('Options','IoDirMode',GetRadioValue('rbReDir'));
  WriteString('Options','IoDirPath',eIoDir.Text);
  WriteString('Options','LastIoDir',LastIoDir);
  WriteInteger('Options','ReDirMode',GetRadioValue('rbIoDir'));
  WriteString('Options','ReDirPath',eReDir.Text);
  WriteString('Options','LastReDir',LastReDir);
  WriteInteger('Options','TmDirMode',GetRadioValue('rbTmDir'));
  WriteString('Options','TmDirPath',eTmDir.Text);
  WriteBool('Options','OpenLast',cbOpenLast.Checked);
  WriteString('Options','LastProject',PrPath);
  WriteInteger('Options','LmbMode',rgLmbMode.ItemIndex);
  WriteInteger('Options','RmbMode',rgRmbMode.ItemIndex);
  WriteInteger('Options','DoubleClick',rgDblMode.ItemIndex);
  WriteInteger('Options','NoEditor',rgNoEditMode.ItemIndex);
  WriteBool('Options','IgnoreLast',cbIgnoreLast.Checked);
  WriteBool('Options','DelTemp',cbDelTemp.Checked);
  WriteBool('Options','SameFile',cbSameFile.Checked);
  WriteBool('Options','IncInfo',cbIncInfo.Checked);
  WriteBool('Options','NoIncPack',cbNoIncPack.Checked);
  WriteInteger('Options','ColourSet',ColourSetIndex);
  WriteBool('Associations','Lpp',cbLpp.Checked);
  WriteBool('Associations','Hqr',cbHqr.Checked);
  WriteBool('Associations','Ile',cbIle.Checked);
  WriteBool('Associations','Obl',cbObl.Checked);
  WriteBool('Associations','Vox',cbVox.Checked);
  WriteBool('Columns','Remember',aRemember.Checked);
  WriteInteger('Columns','Index',FileList.ColWidths[0]);
  WriteInteger('Columns','Offset',FileList.ColWidths[1]);
  WriteInteger('Columns','RlSize',FileList.ColWidths[2]);
  WriteInteger('Columns','CpSize',FileList.ColWidths[3]);
  WriteInteger('Columns','Comp',FileList.ColWidths[4]);
  WriteInteger('Columns','Type',FileList.ColWidths[5]);
  WriteInteger('Columns','Ext',FileList.ColWidths[6]);
  WriteInteger('Columns','Info',FileList.ColWidths[7]);
  WriteInteger('Columns','Repl',FileList.ColWidths[8]);
  WriteBool('State','RemSize',cbRemSize.Checked);
  WriteBool('State','RemPos',cbRemPos.Checked);
  WriteInteger('State','Top',Form1.Top);
  WriteInteger('State','Left',Form1.Left);
  WriteInteger('State','Width',Form1.Width);
  WriteInteger('State','Height',Form1.Height);
  for a:=0 to mRecent.Count-1 do
   WriteString('Recent',IntToStr(a),mRecent.Items[a].Caption);
  for a:=mRecent.Count to 9 do
   DeleteKey('Recent',IntToStr(a));
 end;
 sf.Destroy;
 except
 end;
end;

procedure LoadSettings;
var sf: TIniFile;
    buffer, a, b: Integer;
    capt: String;
begin
 sf:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'LBAPackEd.ini');
 With sf, fSettings, Form1 do begin
  aBlank.Checked:=ReadBool('Options','DispBlank',True);
  aCompact.Checked:=ReadBool('Options','CompBlank',True);
  SetRadioValue('rbOSDir',ReadInteger('Options','OSDirMode',0));
  eOsDir.Text:=ReadString('Options','OsDirPath','');
  LastOsDir:=ReadString('Options','LastOsDir','');
  SetRadioValue('rbIoDir',ReadInteger('Options','IoDirMode',0));
  eIoDir.Text:=ReadString('Options','IoDirPath','');
  LastIoDir:=ReadString('Options','LastIoDir','');
  SetRadioValue('rbReDir',ReadInteger('Options','ReDirMode',0));
  eReDir.Text:=ReadString('Options','ReDirPath','');
  LastReDir:=ReadString('Options','LastReDir','');
  SetRadioValue('rbTmDir',ReadInteger('Options','TmDirMode',0));
  eTmDir.Text:=ReadString('Options','TmDirPath','');
  cbOpenLast.Checked:=ReadBool('Options','OpenLast',False);
  LastProjectPath:=ReadString('Options','LastProject','');
  rgLmbMode.ItemIndex:=ReadInteger('Options','LmbMode',3);
  rgRmbMode.ItemIndex:=ReadInteger('Options','RmbMode',0);
  rgDblMode.ItemIndex:=ReadInteger('Options','DoubleClick',1);
  rgNoEditMode.ItemIndex:=ReadInteger('Options','NoEditor',0);
  cbIgnoreLast.Checked:=ReadBool('Options','IgnoreLast',False);
  cbDelTemp.Checked:=ReadBool('Options','DelTemp',False);
  cbSameFile.Checked:=ReadBool('Options','SameFile',False);
  cbIncInfo.Checked:=ReadBool('Options','IncInfo',False);
  cbNoIncPack.Checked:=ReadBool('Options','NoIncPack',False);
  SwitchColourSet(ReadInteger('Options','ColourSet',0));
  cbColourSet.ItemIndex:=ColourSetIndex;
  cbLpp.Checked:=ReadBool('Associations','Lpp',True);
  cbHqr.Checked:=ReadBool('Associations','Hqr',False);
  cbIle.Checked:=ReadBool('Associations','Ile',False);
  cbObl.Checked:=ReadBool('Associations','Obl',False);
  cbVox.Checked:=ReadBool('Associations','Vox',False);
  aRemember.Checked:=ReadBool('Columns','Remember',True);
  If aRemember.Checked then begin
   FileList.ColWidths[0]:=ReadInteger('Columns','Index',40);
   FileList.ColWidths[1]:=ReadInteger('Columns','Offset',53);
   FileList.ColWidths[2]:=ReadInteger('Columns','RlSize',62);
   FileList.ColWidths[3]:=ReadInteger('Columns','CpSize',52);
   FileList.ColWidths[4]:=ReadInteger('Columns','Comp',12);
   FileList.ColWidths[5]:=ReadInteger('Columns','Type',38);
   FileList.ColWidths[6]:=ReadInteger('Columns','Ext',24);
   FileList.ColWidths[7]:=ReadInteger('Columns','Info',170);
   FileList.ColWidths[8]:=ReadInteger('Columns','Repl',170);
   FileListMouseUp(Form1,mbLeft,[],0,0);
  end;
  cbRemPos.Checked:=ReadBool('State','RemPos',False);
  If cbRemPos.Checked then begin
   Form1.Position:=poDesigned;
   buffer:=ReadInteger('State','Left',-10000);
   If buffer>-10000 then Form1.Left:=buffer;
   buffer:=ReadInteger('State','Top',-10000);
   If buffer>-10000 then Form1.Top:=buffer;
  end;
  cbRemSize.Checked:=ReadBool('State','RemSize',True);
  If cbRemSize.Checked then begin
   buffer:=ReadInteger('State','Width',-1);
   If buffer>-1 then Form1.Width:=buffer;
   buffer:=ReadInteger('State','Height',-1);
   If buffer>-1 then Form1.Height:=buffer;
  end;
  for a:=0 to 9 do begin
   capt:=GetLongName(ReadString('Recent',IntToStr(a),''));
   If capt<>'' then
    mRecent.Add(NewItem(capt,0,False,True,aOpenRecent,0,''));
  end;
  ModMenu.UpdateMenuItem(mRecent,True);
  mRecent.Enabled:=mRecent.Count>0;
 end;
 sf.Destroy;
end;

procedure RefreshDirs;
var ChangeDirTo: String;
    AppDir: String;
begin
 AppDir:=ExtractFilePath(Application.ExeName);
 Case GetRadioValue('rbOsDir') of
  0:ChangeDirTo:=LastOSDir;
  1:ChangeDirTo:=AppDir;
  2:ChangeDirTo:=fSettings.eOsDir.Text;
 end;
 Form1.dOpenProject.InitialDir:=ChangeDirTo;
 Form1.dSaveProject.InitialDir:=ChangeDirTo;
 Case GetRadioValue('rbReDir') of
  0:ChangeDirTo:=LastReDir;
  1:ChangeDirTo:=AppDir;
  2:ChangeDirTo:=fSettings.eReDir.Text;
 end;
 Form1.dOpenReplace.InitialDir:=ChangeDirTo;
 Form1.dSaveEntry.InitialDir:=ChangeDirTo;
 fExtract.eDir.Text:=ChangeDirTo;
 Case GetRadioValue('rbIoDir') of
  0:ChangeDirTo:=LastOSDir;
  1:ChangeDirTo:=AppDir;
  2:ChangeDirTo:=fSettings.eOSDir.Text;
 end;
 Form1.dOpenPack.InitialDir:=ChangeDirTo;
 Form1.dSavePack.InitialDir:=ChangeDirTo;
 Case GetRadioValue('rbTmDir') of
  0:TempDir:=IncludeTrailingPathDelimiter(GetEnvironmentVariable('TEMP'))+'LBAPackEdTemp';
  1:TempDir:=AppDir+'Temp';
  2:TempDir:=IncludeTrailingPathDelimiter(fSettings.eOSDir.Text)+'LBAPackEdTemp';
 end;
end;

function FindRadio(Name: String; Sender: TObject): TComponent;
begin
 Result:=fSettings.FindComponent(Name+Copy((Sender as TRadioButton).Name,3,5));
end;

function GetRbState(Sender: TObject): Boolean;
begin
 Result:=(fSettings.FindComponent('rb'+Copy((Sender as TRadioButton).Name,3,5)+'2') as TRadioButton).Checked;
end;

procedure TfSettings.rbOsDir2Click(Sender: TObject);
begin
 (FindRadio('e',Sender) as TEdit).Enabled:=GetRbState(Sender);
 (FindRadio('b',Sender) as TButton).Enabled:=GetRbState(Sender);
end;

procedure TfSettings.bOsDirClick(Sender: TObject);
var Dir: String;
    BuffEdit: TEdit;
begin
 BuffEdit:=FindComponent('e'+Copy((Sender as TButton).Name,2,5)) as TEdit;
 Dir:=SelectDir(fSettings.Handle,BuffEdit.Text);
 If Dir<>'' then
  BuffEdit.Text:=Dir;
end;

procedure ShowSettingsDialog;
begin
 fSettings.ShowModal;
 RefreshDirs;
 SetAssociations;
end;

procedure TfSettings.rgDblModeClick(Sender: TObject);
begin
 rgNoEditMode.Visible:=rgDblMode.ItemIndex=3;
end;

procedure TfSettings.cbIncInfoClick(Sender: TObject);
begin
 cbNoIncPack.Enabled:=cbIncInfo.Checked;
end;

procedure TfSettings.cbColourSetChange(Sender: TObject);
begin
 SwitchColourSet(cbColourSet.ItemIndex);
end;

end.
