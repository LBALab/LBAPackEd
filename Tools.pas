//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// Tools unit.
// Contains routines used for opening entries with external programs (tools).
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit Tools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IniFiles, ActnList, ExtCtrls, ShellApi,
  ImgList, CheckLst, Menus, CompMods;

type
  TToolsForm = class(TForm)
    OpenProg: TOpenDialog;
    Button4: TButton;
    ExtList: TListView;
    Label18: TLabel;
    eName: TEdit;
    Label19: TLabel;
    ePath: TEdit;
    Button1: TButton;
    Label20: TLabel;
    eParams: TEdit;
    cbUseMenu: TCheckBox;
    cbUseEntry: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    StaticText1: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExtListClick(Sender: TObject);
    procedure eNameChange(Sender: TObject);
    procedure cbUseMenuClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ExtListChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  StrArray = array[0..24] of String;
  BoolArray = array[0..24] of Boolean;

  TThdParams = record
   ProgPath, FilePath, ProgParams: String;
   EntryIndex: Integer;
   Running, Unused, FileChanged, Terminate: Boolean;
   Handle: THandle;
  end;

const
  MaxExt: byte = 23;
  DefaultNames: StrArray = ('some kind of hex editor','image editor','palette editor',
   'text editor','sprite editor','raw sprite editor','3D models editor for LBA 1 files',
   '3D models editor for LBA 2 files','font editor','wave player/editor','voice player/editor',
   'smacker movies player/editor','x-midi player/editor','animation player/editor',
   'gif editor','shape editor','scene editor for LBA 1 files','scene editor for LBA 2 files',
   'brick editor','layouts editor for LBA 1 files','layouts editor for LBA 2 files',
   'grid editor for LBA 1 files','grid editor for LBA 2 files', 'grid fragment editor', 'pcx editor');

var
  ToolsForm: TToolsForm;

  ToolNames: StrArray;
  ToolPaths: StrArray;
  ToolParams: StrArray;
  ToolUseMenu: BoolArray;
  ToolUseEntry: BoolArray;
  ToolEnabled: BoolArray =
   (False, False, False, False, False, False, False, False, False, False, False,
    False, False, False, False, False, False, False, False, False, False, False,
    False, False, False);

  ThdParams: array of TThdParams;
  TempDir: String;

procedure CreateToolMenu;
procedure SetActions(Index: Integer = -1);
Procedure RunTool(TPath, FPath, TParams: String; Entry: Integer);
function Thread(p: pointer): Integer;
Procedure TerminateAllThreads;

implementation

uses files, Settings, LBAPackEd1, Dialog, Info;

{$R *.dfm}

procedure CreateToolMenu;
var a: Integer;
begin
 for a:=0 to MaxExt do begin
  Form1.mTools.Insert(a,NewItem('',0,False,True,Form1.ToolExecute,0,''));
  Form1.mTools.Items[a].Visible:=False;
 end;
 ModMenu.UpdateMenuItem(Form1.mTools,True);
end;

procedure GetIcons;
var sfi: TSHFileInfo;
    Temp: TIcon;
    a: Integer;
begin
 Temp:=TIcon.Create;
 for a:=0 to MaxExt do begin
  If ToolEnabled[a] then begin
   SHGetFileInfo(PChar(ToolPaths[a]),0,sfi,SizeOf(TSHFileInfo),SHGFI_ICON+SHGFI_SMALLICON);
   If sfi.hIcon<>0 then begin
    Temp.Handle:=sfi.hIcon;
    Form1.Images.AddIcon(Temp);
    Form1.mTools.Items[a].ImageIndex:=Form1.Images.Count-1;
   end;
  end;
 end;
 Temp.Destroy;
end;

procedure SetActions(Index: Integer = -1);
var a, b: Integer;
begin
 for a:=0 to MaxExt do begin
  If (Index>-1) and (a<>Index) then Continue;
  b:=0;
  If ToolEnabled[a] and (ToolNames[a]<>'') and (ToolPaths[a]<>'') then begin
   Form1.mTools.Items[a].Caption:=ToolNames[a];
   for b:=0 to a-1 do
    If AnsiSameText(ToolPaths[b],ToolPaths[a]) and
    ((AnsiSameText(ToolParams[b],ToolParams[a]) and ToolUseMenu[b] and ToolUseMenu[a])
    or not (ToolUseMenu[b] or ToolUseMenu[a])) then Break;
  end;
  ToolEnabled[a]:=ToolEnabled[a] and (ToolNames[a]<>'') and (ToolPaths[a]<>'');
  Form1.mTools.Items[a].Visible:=ToolEnabled[a] and (b=a);
 end;
 GetIcons;
 If ToolEnabled[0] then begin
  Form1.aOpenCommon.Caption:='Open selected entry with '+ToolNames[0];
  Form1.mOpenCommon.Caption:='Open this entry with '+ToolNames[0];
  Form1.aOpenCommon.ImageIndex:=Form1.mTools.Items[0].ImageIndex;
 end;
 Form1.aOpenCommon.Visible:=ToolEnabled[0];
 Form1.aOpenCommon.Enabled:=ToolEnabled[0] and Form1.aReplace.Enabled;
 EnableIfNeeded(Form1.FileList.Selection.Top);
end;

procedure TToolsForm.FormCreate(Sender: TObject);
var f: TIniFile;
    a: Integer;
begin
 ExtList.UpdateItems(0,MaxExt);
 f:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'tools.ini');
 for a:=0 to MaxExt do begin
  ToolNames[a]:=f.ReadString(Extensions[a],'Name',DefaultNames[a]);
  ToolPaths[a]:=f.ReadString(Extensions[a],'Path','');
  ToolParams[a]:=f.ReadString(Extensions[a],'Params','');
  ToolUseMenu[a]:=f.ReadBool(Extensions[a],'UseMenu',False);
  ToolUseEntry[a]:=f.ReadBool(Extensions[a],'UseEntry',False);
  ToolEnabled[a]:=f.ReadBool(Extensions[a],'Enabled',False);
  ExtList.Items[a].Checked:=ToolEnabled[a];
 end;
 f.Destroy;
 SetActions;
 ExtList.ItemIndex:=0;
 ExtListClick(Self);
end;

procedure TToolsForm.FormDestroy(Sender: TObject);
var f: TIniFile;
    a: Integer;
begin
 try
 f:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'tools.ini');
 for a:=0 to MaxExt do begin
  f.WriteString(Extensions[a],'Name',ToolNames[a]);
  f.WriteString(Extensions[a],'Path',ToolPaths[a]);
  f.WriteString(Extensions[a],'Params',ToolParams[a]);
  f.WriteBool(Extensions[a],'UseMenu',ToolUseMenu[a]);
  f.WriteBool(Extensions[a],'UseEntry',ToolUseEntry[a]);
  f.WriteBool(Extensions[a],'Enabled',ToolEnabled[a]);
 end;
 f.Destroy;
 except
 end;
end;

procedure TToolsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 SetActions;
end;

Function GetLastWriteTime(Path: String): _FILETIME;
var FileInfo: _WIN32_FIND_DATA;
    FileHandle: Cardinal;
begin
 FileHandle:=FindFirstFile(PChar(Path),FileInfo);
 If FileHandle<>INVALID_HANDLE_VALUE then begin
  Result:=FileInfo.ftLastWriteTime;
  Windows.FindClose(FileHandle);
 end;
end;

Procedure RunTool(TPath, FPath, TParams: String; Entry: Integer);
var ThreadId: Cardinal;
    a: Integer;
begin
 For a:=0 to Length(ThdParams)-1 do
  If ThdParams[a].Unused then Break;
 If a>=Length(ThdParams) then begin
  SetLength(ThdParams,Length(ThdParams)+1);
  a:=Length(ThdParams)-1;
 end;
 ThdParams[a].ProgPath:=TPath;
 ThdParams[a].FilePath:=FPath;
 ThdParams[a].ProgParams:=TParams;
 ThdParams[a].EntryIndex:=Entry;
 ThdParams[a].Terminate:=False;
 //If pIndex=-1 then begin
 // pIndex:=a;
  ThdParams[a].Handle:=BeginThread(nil,0,@Thread,Pointer(a),0,ThreadId);
  If ThdParams[a].Handle<>0 then begin
   ThdParams[a].Unused:=False;
   ThdParams[a].Running:=True;
   SetThreadPriority(ThdParams[a].Handle,THREAD_PRIORITY_IDLE);
  end;
 // else pIndex:=-1;
 //end;
end;

function Thread(p: pointer): Integer;
var SI: TStartupInfo;
    PI: TProcessInformation;
    S: String;
    FileTime: _FILETIME;
    a: Integer;
begin
 //a:=pIndex;
 //pIndex:=-1;
 a:=Integer(p);
 S:='"'+ThdParams[a].ProgPath+'"';
 If ThdParams[a].ProgParams<>'' then S:=S+' "'+ThdParams[a].ProgParams+'"';
 S:=S+' "'+ThdParams[a].FilePath+'"';
 FileTime:=GetLastWriteTime(ThdParams[a].FilePath);

 FillChar(SI,sizeof(SI),0);
 with SI do begin
  dwFlags:=STARTF_USESHOWWINDOW;
  wShowWindow:=SW_SHOW;
  cb:=sizeof(TStartupInfo);
 end;

 if CreateProcess(nil,PChar(S),nil,nil,FALSE,NORMAL_PRIORITY_CLASS,nil,nil,SI,PI) then begin
  with PI do begin
   repeat until (WaitForInputIdle(hProcess,100)<>WAIT_TIMEOUT) or ThdParams[a].Terminate;
   repeat until (WaitForSingleObject(hProcess,100)<>WAIT_TIMEOUT) or ThdParams[a].Terminate;
   repeat until (WaitForSingleObject(hThread,100)<>WAIT_TIMEOUT) or ThdParams[a].Terminate;
   CloseHandle(hProcess);
   CloseHandle(hThread);
  end;

  ThdParams[a].FileChanged:=CompareFileTime(FileTime,GetLastWriteTime(ThdParams[a].FilePath))<>0;
  ThdParams[a].Running:=False;
 end;
end;

Procedure TerminateAllThreads;
var a: Integer;
begin
 for a:=0 to Length(ThdParams)-1 do
  If ThdParams[a].Running then TerminateThread(ThdParams[a].Handle,0);
 SetLength(ThdParams,0);
end;

Procedure EnableEdit(Enable: Boolean);
begin
 ToolsForm.eName.Enabled:=Enable;
 ToolsForm.ePath.Enabled:=Enable;
 ToolsForm.eParams.Enabled:=Enable;
 ToolsForm.Button1.Enabled:=Enable;
 ToolsForm.cbUseMenu.Enabled:=Enable;
 ToolsForm.cbUseEntry.Enabled:=Enable;
end;

procedure TToolsForm.ExtListClick(Sender: TObject);
begin
 If ExtList.ItemIndex>=0 then begin
  eName.Text:=ToolNames[ExtList.ItemIndex];
  ePath.Text:=ToolPaths[ExtList.ItemIndex];
  eParams.Text:=ToolParams[ExtList.ItemIndex];
  cbUseMenu.Checked:=ToolUseMenu[ExtList.ItemIndex];
  cbUseEntry.Checked:=ToolUseEntry[ExtList.ItemIndex];
 end;
 EnableEdit(ExtList.ItemIndex>=0);
end;

procedure TToolsForm.eNameChange(Sender: TObject);
begin
 If (Sender as TEdit).Name='eName' then
  ToolNames[ExtList.ItemIndex]:=eName.Text
 else if (Sender as TEdit).Name='ePath' then
  ToolPaths[ExtList.ItemIndex]:=ePath.Text
 else if (Sender as TEdit).Name='eParams' then
  ToolParams[ExtList.ItemIndex]:=eParams.Text;
end;

procedure TToolsForm.cbUseMenuClick(Sender: TObject);
begin
 If (Sender as TCheckBox).Name='cbUseMenu' then
  ToolUseMenu[ExtList.ItemIndex]:=cbUseMenu.Checked
 else if (Sender as TCheckBox).Name='cbUseEntry' then
  ToolUseEntry[ExtList.ItemIndex]:=cbUseEntry.Checked;
end;

procedure TToolsForm.Button1Click(Sender: TObject);
begin
 OpenProg.InitialDir:=ExtractFilePath(ePath.Text);
 If OpenProg.Execute then
  ePath.Text:=OpenProg.FileName;
end;

procedure TToolsForm.ExtListChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var a: Integer;
begin
 a:=ExtList.Items.IndexOf(Item);
 If ToolEnabled[a]=not Item.Checked then begin
  ToolEnabled[a]:=Item.Checked;
  SetActions(a);
  Item.Checked:=ToolEnabled[a];
 end;
end;

end.
