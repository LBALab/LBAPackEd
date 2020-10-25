//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// LBAPackEd1 unit.
// This is the main unit. Contains all main window events.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit LBAPackEd1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ComCtrls, Buttons, ExtCtrls, ImgList, IniFiles,
  ShellApi, Menus, ActnList, StdActns, ToolWin, TLHelp32, StrUtils, Hint;


type
  TForm1 = class(TForm)
    FileList: TStringGrid;
    dOpenPack: TOpenDialog;
    Status1: TStatusBar;
    dSavePack: TSaveDialog;
    dSaveProject: TSaveDialog;
    dOpenProject: TOpenDialog;
    Panel1: TPanel;
    InLabel: TLabel;
    OutLabel: TLabel;
    bChangeIn: TButton;
    bChangeOut: TButton;
    dOpenReplace: TOpenDialog;
    Panel2: TPanel;
    Shape1: TShape;
    Label1: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dSaveEntry: TSaveDialog;
    InfAll: TStaticText;
    InfReal: TStaticText;
    InfHidden: TStaticText;
    InfRep: TStaticText;
    InfBlank: TStaticText;
    ToolBar1: TToolBar;
    tbLoadInput: TToolButton;
    tbOpenProject: TToolButton;
    tbSaveProject: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    tbDispAll: TToolButton;
    tbDispRH: TToolButton;
    ToolButton3: TToolButton;
    tbSettings: TToolButton;
    ToolButton5: TToolButton;
    tbReplace: TToolButton;
    tbClear: TToolButton;
    tbClearAll: TToolButton;
    ToolButton6: TToolButton;
    tbExtract: TToolButton;
    ToolButton8: TToolButton;
    tbChangeOut: TToolButton;
    ToolButton9: TToolButton;
    tbBuild: TToolButton;
    ToolButton7: TToolButton;
    Images: TImageList;
    Timer1: TTimer;
    Label5: TLabel;
    ToolButton10: TToolButton;
    tbUnloadPack: TToolButton;
    lb_filedesc: TLabel;
    Label6: TLabel;
    ToolButton11: TToolButton;
    Edit1: TEdit;
    bSame: TBitBtn;
    ThdTimer: TTimer;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EntriesMenu: TPopupMenu;
    DisabledMenu: TPopupMenu;
    MultiMenu: TPopupMenu;
    mThisEntry: TMenuItem;
    mOpen: TMenuItem;
    mOpenCommon: TMenuItem;
    N1: TMenuItem;
    mReplace: TMenuItem;
    mReplaceTemp: TMenuItem;
    N2: TMenuItem;
    mClearRepl: TMenuItem;
    mClearAll: TMenuItem;
    N3: TMenuItem;
    mExtract: TMenuItem;
    mExtractTemp: TMenuItem;
    mExtractPart: TMenuItem;
    hisentryisblank2: TMenuItem;
    N6: TMenuItem;
    Youcandonothingwithblankentries1: TMenuItem;
    Morethanoneentryselected1: TMenuItem;
    N7: TMenuItem;
    Replaceselectedentrieswith2: TMenuItem;
    Replaceselentrieswiththeonesfromtemp4: TMenuItem;
    N8: TMenuItem;
    Clearreplacementsforselectedentries2: TMenuItem;
    ClearreplacementsforALLentries3: TMenuItem;
    N10: TMenuItem;
    Extractselectedentries2: TMenuItem;
    Extractselectedentriestotempdirectory4: TMenuItem;
    Partialextract3: TMenuItem;
    ActionList: TActionList;
    aOffset: TAction;
    aRlSize: TAction;
    aCpSize: TAction;
    aComp: TAction;
    aType: TAction;
    aExt: TAction;
    aInfo: TAction;
    aRepl: TAction;
    aRemember: TAction;
    aOpen: TAction;
    aOpenCommon: TAction;
    aReplace: TAction;
    aReplaceTemp: TAction;
    aClear: TAction;
    aClearAll: TAction;
    aSelectOut: TAction;
    aBuild: TAction;
    aExtractTemp: TAction;
    aExtract: TAction;
    aExtractPart: TAction;
    aOpenPack: TAction;
    aReload: TAction;
    aUnloadPack: TAction;
    aOpenProject: TAction;
    aSaveProject: TAction;
    aRecent: TAction;
    aExit: TAction;
    aAbout: TAction;
    aShowHints: TAction;
    aConfigTools: TAction;
    aBlank: TAction;
    aCompact: TAction;
    aSettings: TAction;
    mMain: TMainMenu;
    File1: TMenuItem;
    View1: TMenuItem;
    Columns1: TMenuItem;
    Commands1: TMenuItem;
    mTools: TMenuItem;
    Help1: TMenuItem;
    Loadpackagefile1: TMenuItem;
    Reloadpackage1: TMenuItem;
    Unloadpackage1: TMenuItem;
    N4: TMenuItem;
    Openproject1: TMenuItem;
    N5: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    Displayblankentries1: TMenuItem;
    Compactblankentries1: TMenuItem;
    N12: TMenuItem;
    Settings1: TMenuItem;
    mOffset: TMenuItem;
    mRlSize: TMenuItem;
    mCpSize: TMenuItem;
    mComp: TMenuItem;
    mType: TMenuItem;
    mExt: TMenuItem;
    mInfo: TMenuItem;
    mRepl: TMenuItem;
    N13: TMenuItem;
    Rememberthesesettings1: TMenuItem;
    Openselectedentrywith1: TMenuItem;
    Openwith1: TMenuItem;
    Clearopenedindicatorforselectedentry1: TMenuItem;
    N14: TMenuItem;
    Replaceselectedentrieswith1: TMenuItem;
    Replaceselentrieswiththeonesfromtemp1: TMenuItem;
    N15: TMenuItem;
    Clearreplacementsforselectedentries1: TMenuItem;
    ClearreplacementsforALLentries1: TMenuItem;
    N16: TMenuItem;
    Specifyoutputfile1: TMenuItem;
    Buildoutputfile1: TMenuItem;
    N17: TMenuItem;
    Extractselectedentries1: TMenuItem;
    Partialextract1: TMenuItem;
    Extractselectedentriestotempdirectory1: TMenuItem;
    Configuretools1: TMenuItem;
    About1: TMenuItem;
    Showhints1: TMenuItem;
    N20: TMenuItem;
    mRecent: TMenuItem;
    N18: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FileListSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FileListDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure WMDropFiles (hDrop : THandle; hWindow : HWnd);
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    procedure AppException(Sender: TObject; E: Exception);
    procedure aBlankExecute(Sender: TObject);
    procedure FileListDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure aChangeOutExecute(Sender: TObject);
    procedure aBuildExecute(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure aLoadInputExecute(Sender: TObject);
    procedure FileListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure aReplaceExecute(Sender: TObject);
    procedure aClearExecute(Sender: TObject);
    procedure aSaveProjectExecute(Sender: TObject);
    procedure aOpenProjectExecute(Sender: TObject);
    procedure aClearAllExecute(Sender: TObject);
    procedure aSettingsExecute(Sender: TObject);
    procedure FileListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FileListEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure FileListStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FileListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure aExtractExecute(Sender: TObject);
    procedure aExtractPartExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FileListMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FileListMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure aUnloadPackExecute(Sender: TObject);
    procedure aAboutExecute(Sender: TObject);
    procedure FileListDblClick(Sender: TObject);
    procedure ColumnsMenuClick(Sender: TObject);
    procedure aReloadExecute(Sender: TObject);
    procedure aOpenRecent(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure EmptyActionExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aConfigureExecute(Sender: TObject);
    procedure ToolExecute(Sender: TObject);
    procedure aOpenExecute(Sender: TObject);
    procedure bSameClick(Sender: TObject);
    procedure ThdTimerTimer(Sender: TObject);
    procedure aExtractTempExecute(Sender: TObject);
    procedure aReplaceTempExecute(Sender: TObject);
    procedure aClearOpenedExecute(Sender: TObject);
   // procedure dOpenPackFilePreview(Sender: TObject; const Filename: string; Canvas: TCanvas;
    // const Rect: TRect; Progress: TProgressEvent; var Handled: Boolean);
  private
    { Private declarations }
  public
    Procedure AppShowHint(var HintStr: String; var CanShow: Boolean;
     var HintInfo: THintInfo);
  end;

const VNum = '0.11';

var
  Form1: TForm1;
  DirPath: String;
  OutSpec: Boolean = false;
  Modified: Boolean = False;
  //hThread: THandle;
  LastOsDir: String;
  LastReDir: String;
  LastIoDir: String;
  HintParam: Integer;

  DragRow: Integer;
  DragStarted: Boolean = False;
  ClickedRow: Integer;
  DragType: (dtNone, dtEntry, dtRepl);
  DragPoint: TPoint;
  DraggingUp: Boolean;

  SelectedRows: array of Boolean;
  SelectCount: Integer = 0;
  NoSelect: Boolean = False;
  DoubleClick: Boolean = False;

  SMSelected, SMEntries: ShortString;

//function MsgThread(p: pointer): Integer;
function FindRow(index: Integer):Integer;
Procedure EnableMenus(Enable: Boolean);
procedure EnableIfNeeded(ARow: Integer);
procedure SetReplacement(ARow: Integer; Path: String);
procedure DopasujRozmiar;

implementation

uses ProgBar, files, Math, Settings, DePack, ExtractDlg, About, Info,
  Tools, Dialog;

{$R *.dfm}

Procedure EnableMenus(Enable: Boolean);
begin
 Form1.aSaveProject.Enabled:=Enable;
 Form1.aReplace.Enabled:=Enable;
 Form1.aClear.Enabled:=Enable;
 Form1.aClearAll.Enabled:=Enable;
 Form1.aSelectOut.Enabled:=Enable;
 Form1.bSame.Enabled:=Enable;
 Form1.aOpen.Enabled:=Enable;
 Form1.aOpenCommon.Enabled:=Enable;
 Form1.aExtract.Enabled:=Enable;
 Form1.aExtractPart.Enabled:=Enable;
 Form1.aBuild.Enabled:=Enable;
 Form1.aUnloadPack.Enabled:=Enable;
 Form1.aReload.Enabled:=Enable;
 Form1.aExtractTemp.Enabled:=Enable;
 Form1.aReplaceTemp.Enabled:=Enable;
end;

Procedure DisableAll;
var a: Integer;
begin
 //Form1.mMain.Enabled:=False;
 for a:=0 to Form1.ActionList.ActionCount-1 do
  (Form1.ActionList.Actions[a] as TAction).Enabled:=False;
end;

Procedure EnableAll;
var a: Integer;
begin
 //Form1.mMain.Enabled:=True;
 for a:=0 to Form1.ActionList.ActionCount-1 do
  (Form1.ActionList.Actions[a] as TAction).Enabled:=True;
end;

procedure SetSingleMulti(Multi, OpenAllowed: Boolean);
begin
 If Multi then begin
  SMSelected:='selected';
  SMEntries:='entries';
  Form1.mThisEntry.ImageIndex:=-1;
  Form1.mThisEntry.Caption:='More than one entry selected';
  Form1.mOpen.Visible:=OpenAllowed;
  Form1.mReplaceTemp.Caption:='Replace sel. entries with the ones from temp';
 end
 else begin
  SMSelected:='this';
  SMEntries:='entry';
  Form1.mOpen.Visible:=True;
  Form1.mReplaceTemp.Caption:='Replace this entry with the one from temp';
 end;
 Form1.mReplace.Caption:=Format('Replace %s %s with...',[SMSelected,SMEntries]);
 Form1.mClearRepl.Caption:=Format('Clear replacement for %s %s',[SMSelected,SMEntries]);
 Form1.mExtract.Caption:=Format('Extract %s %s...',[SMSelected,SMEntries]);
 Form1.mExtractTemp.Caption:=Format('Extract %s %s to temp directory',[SMSelected,SMEntries]);
end;

function CheckSameEditors: Boolean; //Checks if all the selected entries have the same editor
var a, First, Index: Integer;
begin
 First:=-1;
 Result:=True;
 For a:=1 to Form1.FileList.RowCount-1 do
  If SelectedRows[a] then begin
   Index:=Entries[DispMap[a]].ExtIndex;
   If Index=2 then Continue;
   If First=-1 then begin First:=Index; Continue; end;
   If not (AnsiSameText(ToolPaths[Index],ToolPaths[First]) and
   ((AnsiSameText(ToolParams[Index],ToolParams[First]) and ToolUseMenu[Index] and ToolUseMenu[First])
   or not (ToolUseMenu[Index] or ToolUseMenu[First]))) then begin
    Result:=False;
    Exit;
   end;
  end;
end;

function GetFirstSelected: Integer;
var a, LastFirst: Integer;
begin
 Result:=0;
 for a:=1 to Form1.FileList.RowCount-1 do
  If SelectedRows[a] then begin
   LastFirst:=a;
   If Entries[DispMap[a]].ExtIndex=2 then Continue;
   Result:=a;
   Exit;
  end;
 If Result=0 then Result:=LastFirst; 
end;

procedure SetEditor(Image: Integer; CaptionPopup, CaptionMain: String);
begin
 Form1.aOpen.Caption:=CaptionMain;
 Form1.mOpen.Caption:=CaptionPopup;
 Form1.aOpen.ImageIndex:=Image;
 Form1.aOpen.Enabled:=Image>-1;
 Form1.mOpen.Enabled:=Image>-1;
end;

procedure EnableOpenWith;
begin
 Form1.aOpenCommon.ImageIndex:=Form1.mTools.Items[0].ImageIndex;
 Form1.aOpenCommon.Caption:=Format('Open selected %s with %s',[SMEntries,ToolNames[0]]);
 Form1.mOpenCommon.Caption:=Format('Open %s %s with %s',[SMSelected,SMEntries,ToolNames[0]]);
 Form1.aOpenCommon.Enabled:=True;
end;

Procedure DisableReplace(FType: Integer);
begin
 Form1.aReplace.Enabled:=False;
 Form1.aClear.Enabled:=False;
 Form1.aExtract.Enabled:=False;
 Form1.aOpen.Enabled:=False;
 Form1.aOpenCommon.Enabled:=False;
 {for a:=1 to Length(SelectedRows)-1 do
  If SelectedRows[a] then begin
   Form1.aReplace.Enabled:=True;
   Form1.aClear.Enabled:=True;
   Form1.aExtract.Enabled:=True;
   Break;
  end; }
 If FType=-2 then
  Form1.DisabledMenu.Items.Items[0].Caption:='This entry is blank'
 else
  Form1.DisabledMenu.Items.Items[0].Caption:='This entry is repeated';
 SetEditor(-1,'No editor/viewer associated','No editor/viewer associated');
 Form1.FileList.PopupMenu:=Form1.DisabledMenu;
 Form1.Status1.Panels[1].Text:='';
end;

Procedure EnableReplace(ext: Byte);
var buff: String;
    a, b: Integer;
begin
 With Form1 do begin
  aReplace.Enabled:=True;
  aClear.Enabled:=True;
  aExtract.Enabled:=True;
  aOpen.Enabled:=True;
  aOpenCommon.Enabled:=SelectCount=1;
  {If SelectCount<>1 then begin
   FileList.PopupMenu:=MultiMenu;
   SetEditor(-1,'','More than one entry selected');
  end
  else} begin
   FileList.PopupMenu:=EntriesMenu;
   SetSingleMulti(SelectCount>1,CheckSameEditors);
   If SelectCount=1 then begin
    buff:=GetDescription(ext);
    mThisEntry.ImageIndex:=19;
    If UnknownPack then
     mThisEntry.Caption:='Current package file is not known'
    else begin
     If buff='unknown file' then
      mThisEntry.Caption:='This entry is not known yet'
     else begin
      mThisEntry.Caption:='This entry is known as '+buff+' (.'+Extensions[ext]+')';
      mThisEntry.ImageIndex:=ext+19;
     end;
    end;
   end;
   EnableOpenWith;
   If SelectCount>1 then ext:=Entries[DispMap[GetFirstSelected]].ExtIndex;
   If ToolEnabled[ext] and (ext<>0) then
    SetEditor(mTools.Items[ext].ImageIndex,
     Format('Open %s %s with %s',[SMSelected,SMEntries,ToolNames[ext]]),
     Format('Open selected %s with %s',[SMEntries,ToolNames[ext]]))
   else
    SetEditor(-1,'No editor/viewer associated','No editor/viewer associated');
   If FileList.Dragging then
    Status1.Panels[1].Text:=''
   else
    Status1.Panels[1].Text:='Press <Enter> or <F2> to begin manual replacement editing';
  end;
 end;
end;

procedure CheckModified;
begin
 If Modified then
  case MessageBox(Form1.handle,'Current set of replacements or input/output file path has been changed. Do you want to save it as project file?','LBA Package Editor',MB_ICONQUESTION+MB_YESNOCANCEL) of
   ID_YES: begin
    Form1.aSaveProjectExecute(Form1);
    if Modified then Abort;
   end; 
   ID_CANCEL: Abort;
  end;
end;

Function IsAnyReplaced: Boolean;
var a: Integer;
begin
 Result:=True;
 for a:=0 to FCount-1 do
  If Entries[a].Replace<>'' then Exit;
 Result:=False;
end;

Procedure TForm1.AppShowHint(var HintStr: String; var CanShow: Boolean;
 var HintInfo: THintInfo);
var ARow, ACol: Integer;
    p: TPoint;
    s: String;
begin
 If HintInfo.HintControl is TLabel then begin
  HintInfo.HintWindowClass:=THintLabel;
  HintInfo.HintPos.X:=HintInfo.HintControl.ClientOrigin.X-3;
  HintInfo.HintPos.Y:=HintInfo.HintControl.ClientOrigin.Y-1;
 end
 else if HintInfo.HintControl = FileList then begin
  p:=FileList.ScreenToClient(Mouse.CursorPos);
  FileList.MouseToCell(p.X,p.Y,ACol,ARow);
  CanShow:=False;
  If (FileList.ColCount>=ACol) and (FileList.RowCount>=ARow) then begin
   s:=FileList.Cells[ACol,ARow];
   If (s<>'') and ((ACol=7) or (ACol=8))
   and ((FileList.Canvas.TextWidth(s)>FileList.ColWidths[ACol]-2)
   or ((ACol=8) and (s<>Entries[DispMap[ARow]].Replace) and (s[1]<>'>'))) then begin
    HintInfo.HintWindowClass:=THintList;
    If ACol=8 then begin
     HintStr:=Entries[DispMap[ARow]].Replace;
     HintParam:=-1;
    end
    else begin
     HintStr:=s;
     HintParam:=Entries[DispMap[ARow]].ExtIndex;
    end;
    HintInfo.HintData:=@HintParam;
    p:=FileList.ClientToScreen(FileList.CellRect(ACol,ARow).TopLeft);
    HintInfo.HintPos.X:=p.X-1;
    HintInfo.HintPos.Y:=p.Y-1;
    HintInfo.ReshowTimeout:=100;
    CanShow:=True;
   end;
  end;
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
//var ThreadId: Cardinal;
begin
 CreateToolMenu;
 Form1.Label7.Caption:='Version: '+VNum;
 With FileList do begin
  Cells[0,0]:='Nr';
  Cells[1,0]:='Offset';
  Cells[2,0]:='Orig. size';
  Cells[3,0]:='Packed size';
  Cells[4,0]:='C';
  Cells[5,0]:='Type';
  Cells[6,0]:='Ext';
  Cells[7,0]:='Info';
  Cells[8,0]:=' will be replaced with';
 end;
 dSaveEntry.Filter:='Unknown file (*.lun)|*.lun|LBA image (*.lim)|*.lim|Palette file (*.pal)|*.pal|LBA text file (*.lbt)|*.lbt|LBA sprite (*.lsp)|*.lsp|LBA Raw sprite (*.lsr)|*.lsr|LBA 1 3D model (*.lm1)|*.lm1|LBA 2 3D model (*.lm2)|*.lm2|'+
  'LBA font file (*.lfn)|*.lfn|Riff wave file (*.wav)|*.wav|Creative voice file (*.voc)|*.voc|Smacker movie (*.smk)|*.smk|XMidi file (*.xmi)|*.xmi|LBA animation (*.anm)|*.anm|Graphics image (*.gif)|*.gif|LBA shape file (*.lsh)|*.lsh|'+
  'LBA 1 scene (*.ls1)|*.ls1|LBA 2 scene (*.ls2)|*.ls2|LBA brick file (*.brk)|*.brk|LBA 1 layouts library (*.bl1)|*.bl1|LBA 2 layouts library (*.bl2)|*.bl2|LBA 1 grid file (*.gr1)|*.gr1|LBA 2 grid file (*.gr2)|*.gr2|ZSoft paintbrush (*.pcx)|*.pcx|'+
  'LBA 2 grid fragment (*.grf)|*.grf';

 Application.OnMessage:=AppMessage;
 Application.OnException:=AppException;
 Application.OnShowHint:=AppShowHint;

 //dOpenPack.Options:=dOpenPack.Options+[ofPreview,ofAutoPreview];
 //dOpenPack.OnFilePreview:=dOpenPackFilePreview;

 DragAcceptFiles(Form1.Handle,True);
 //hThread:=BeginThread(nil,0,@MsgThread,nil,0,ThreadId);
 //SetThreadPriority(hThread,THREAD_PRIORITY_LOWEST);
 dOpenReplace.FilterIndex:=1;
 //Application.OnHint:=AppHint;
end;

procedure SetReplacement(ARow: Integer; Path: String);
begin
 If not (InLoaded and Displayed) then Exit;
 If IsBlank(DispMap[ARow]) then begin
  MessageBox(Form1.Handle,'Blank entries cannot be replaced!','LBA Package Editor',MB_ICONERROR+MB_OK);
  Exit;
 end;
 Entries[DispMap[ARow]].Replace:= Path;
 If Copy(Path,1,1)='>' then
  Form1.FileList.Cells[8,ARow]:='>'+Form1.FileList.Cells[0,FindRow(StrToInt(Copy(Path,2,Length(Path)-1)))]
 else
  Form1.FileList.Cells[8,ARow]:=MinPath(Path);
 Modified:=True;
end;

function FindRow(index: Integer):Integer;
var a: Integer;
begin
 for a:=1 to Length(DispMap)-1 do
  If DispMap[a]=index then begin
   Result:=a;
   Exit;
  end;
 Result:=0;
end;

Procedure Unselect(ARow: Integer);
var a: Integer;
    cr: TRect;
begin
 With Form1.FileList do begin
  Canvas.Brush.Color:=clWindow;
  For a:=0 to 8 do begin
   cr:=CellRect(a,ARow);
   Canvas.FillRect(cr);
   Canvas.TextOut(cr.Left+2,cr.Top+2,Cells[a,ARow]);
  end;
 end;
end;

function IsNormalSelected: Boolean;
var a: Integer;
begin
 Result:=False;
 With Form1.FileList do
  for a:=0 to Length(SelectedRows)-1 do
   If SelectedRows[a] and
   (IsNorm(DispMap[a]) or IsHidden(DispMap[a]) or IsRep(DispMap[a])) then begin
    Result:=True;
    Exit;
   end;
end;

function SelectedRow: Integer;
var a: Integer;
begin
 for a:=1 to Length(SelectedRows)-1 do
  If SelectedRows[a] then begin
   Result:=a;
   Exit;
  end;
 Result:=-1;  
end;

procedure EnableIfNeeded(ARow: Integer);
begin
 If InLoaded and Displayed then begin
  If IsNormalSelected then EnableReplace(Entries[DispMap[ARow]].ExtIndex)
  else DisableReplace(Entries[DispMap[ARow]].FType);
 end; 
end;

procedure SelectCell(ACol, ARow: Integer; NoKeys: Boolean = False);
var a, c: Integer;
    Shift: TShiftState;
begin
 If not Displayed then Exit;
 If NoSelect then Exit;

 If NoKeys then Shift:=[] else Shift:=KeyboardStateToShiftState;
 With Form1.FileList do begin
  {If not Form1.Filelist.Dragging then} begin
   If (ssCtrl in Shift) then begin
    If SelectedRows[ARow] then begin
     SelectedRows[ARow]:=False;
     Dec(SelectCount);
     If ARow=Selection.Top then
      Unselect(ARow);
    end
    else begin
     SelectedRows[ARow]:=True;
     Inc(SelectCount);
    end;
   end
   else if (ssShift in Shift) then begin
    for a:=Min(ARow,Selection.Top) to Max(ARow,Selection.Top) do
     If not SelectedRows[a] then begin
      SelectedRows[a]:=True;
      Inc(SelectCount);
     end;
    Repaint;
   end
   else begin
    SetLength(SelectedRows,0);
    SetLength(SelectedRows,RowCount);
    SelectedRows[ARow]:=True;
    If (SelectCount<>1) and not Dragging then Repaint;
    SelectCount:=1;
   end;
   Form1.Label5.Caption:='Selected: '+IntToStr(SelectCount);
  end;

  For a:=1 to RowCount-1 do
   If Cells[0,a][1]='+' then
    Cells[0,a]:=Copy(Cells[0,a],2,Length(Cells[0,a])-1);
  If (Cells[5,ARow]='Normal') then
   for a:=0 to FCount-1 do
    If Entries[a].FType=DispMap[ARow] then begin
     c:=FindRow(a);
     If c>0 then
      Cells[0,c]:='+'+Cells[0,c];
    end;
  EnableIfNeeded(ARow);
 end;
end;

procedure TForm1.FileListSelectCell(Sender: TObject; ACol, ARow: Integer;
var CanSelect: Boolean);
begin
 SelectCell(ACol,ARow);
end;

function BottomRow: Integer;
begin
 Result:=(Form1.FileList.Height div Form1.FileList.DefaultRowHeight)+Form1.Filelist.TopRow-3;
end;

procedure TForm1.FileListDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var ARow, ACol: Integer;
    cr: TRect;
begin
 If DragStarted then
  FileList.MouseToCell(x,y,ACol,DragRow);
 DragStarted:=False;
 Accept:=False;
 If not (InLoaded and Displayed) then Exit;
 If SelectCount<>1 then Exit;
 FileList.MouseToCell(x,y,ACol,ARow);

 If ARow=0 then begin
  DraggingUp:=True;
  Timer1.Enabled:=True;
 end
 else if ARow>=BottomRow then begin
  DraggingUp:=False;
  Timer1.Enabled:=True;
 end else Timer1.Enabled:=False;

 If ARow>0 then begin
  FileList.Selection:=TGridRect(Rect(0,ARow,8,ARow));
  SelectCell(0,ARow);
  If (DragRow=0) or (DragRow=ARow) then Exit;
  If Source=FileList then begin
   If (ARow<>DragRow) and (FileList.TopRow<=DragRow) and (BottomRow>=DragRow) then begin
    FileList.Canvas.Brush.Color:=clMoneyGreen;
    Case DragType of
     dtEntry: For ACol:=0 to 7 do begin
      cr:=FileList.CellRect(ACol,DragRow);
      FileList.Canvas.FillRect(cr);
      FileList.Canvas.TextOut(cr.Left+2,cr.Top+2,FileList.Cells[ACol,DragRow]);
     end;
     dtRepl: begin
      cr:=FileList.CellRect(8,DragRow);
      FileList.Canvas.FillRect(cr);
      FileList.Canvas.TextOut(cr.Left+2,cr.Top+2,FileList.Cells[8,DragRow]);
     end;
    end;
   end;
   If IsBlank(DispMap[DragRow]) or IsBlank(DispMap[ARow]) then Exit;
   If (DragType=dtEntry) and (IsHidden(DispMap[DragRow]) or IsHidden(DispMap[ARow])) then Exit;
   Accept:=True;
  end;
 end;
end;

procedure TForm1.FileListStartDrag(Sender: TObject; var DragObject: TDragObject);
begin
 DragStarted:=True;
 If DragType=dtRepl then Form1.Status1.Panels[1].Text:='Press <Alt> to move with copy';
end;

procedure TForm1.FileListDragDrop(Sender, Source: TObject; X, Y: Integer);
var ShiftState: TShiftState;
    ACol, ARow: Integer;
    Old: String;
begin
 FileList.MouseToCell(x,y,ACol,ARow);
 ShiftState:=KeyboardStateToShiftState;
 If DragType=dtRepl then begin
  Old:=Entries[DispMap[ARow]].Replace;
  SetReplacement(ARow,Entries[DispMap[DragRow]].Replace);
  If not (ssAlt in ShiftState) then
   If Old<>'' then
    SetReplacement(DragRow,Old)
   else
    SetReplacement(DragRow,'');
 end
 else
  SetReplacement(ARow,'>'+IntToStr(DispMap[DragRow]));
end;

procedure TForm1.FileListEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
 Timer1.Enabled:=False;
 FileList.Repaint;
 DragPoint:=FileList.ClientToScreen(DragPoint);
 If (DragPoint.x=x) and (DragPoint.y=y) then
  FileList.PopupMenu.Popup(x,y);
end;

function Instances: Integer;  //returns number of running instatces of this prog
var FSnapshotHandle: THandle; //...actually number of running progs with the same file name
    FProcessEntry32:TProcessEntry32;
    Licznik: Integer; //counter
begin
 FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
 FProcessEntry32.dwSize:=Sizeof(FProcessEntry32);
 Licznik:=0;
 If Process32First(FSnapshotHandle,FProcessEntry32) then
  repeat
   If AnsiSameText(FProcessEntry32.szExeFile,ExtractFileName(Application.ExeName)) then Inc(Licznik);
  until not Process32Next(FSnapshotHandle,FProcessEntry32);
 CloseHandle(FSnapshotHandle);
 Result:=Licznik;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var sr: TSearchRec;
begin
 CheckModified;
 DragAcceptFiles(FileList.Handle, False);
 DragAcceptFiles(Form1.Handle,False);
 SaveSettings;
 If fSettings.cbDelTemp.Checked and DirectoryExists(TempDir) and (Instances<=1) then begin
  If FindFirst(TempDir+'\*.*',faAnyFile,sr)=0 then
   repeat
    If (sr.Name<>'.') and (sr.Name<>'..') then DeleteFile(TempDir+'\'+sr.Name);
   until FindNext(sr)<>0;
  FindClose(sr);
  RemoveDir(TempDir+'\');
 end;
end;

//obs³uga Drag & Drop

procedure TForm1.WMDropFiles (hDrop : THandle; hWindow : HWnd);
var
  TotalNumberOfFiles, nFileLength, ACol, ARow: Integer;
  pszFileName: PChar;
  DropPoint: TPoint;
begin
  //liczba zrzuconych plików
  TotalNumberOfFiles:=DragQueryFile(hDrop,$FFFFFFFF,nil,0);
  If TotalNumberOfFiles=1 then begin
   nFileLength:=DragQueryFile(hDrop,0,Nil,0)+1;
   GetMem(pszFileName,nFileLength);
   DragQueryFile(hDrop,0,pszFileName,nFileLength);
   DragQueryPoint(hDrop,DropPoint);
   //pszFileName - nazwa upuszczonego pliku
   //tutaj robimy coœ z nazw¹ pliku
   If FindControl(hWindow).Name='FileList' then begin
    FileList.MouseToCell(DropPoint.x,DropPoint.y,ACol,ARow);
    if ARow>0 then
     SetReplacement(ARow, pszFileName)
    else
     Beep;
   end
   else begin
    try    //¿eby wykona³o siê FreeMem je¿eli bêdzie b³¹d
     CheckModified;
     UnloadPack;
     OpenParam(pszFileName);
    except
    end;
   end;

   FreeMem(pszFileName,nFileLength);
  end
  else
   MessageBox(handle,'You can''t replace one entry with more than one file.','LBA Package Editor',MB_ICONERROR+MB_OK);

  DragFinish(hDrop);
end; //sprawdzamy co zosta³o przeci¹gniête i obs³ugujemy to

procedure TForm1.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  case Msg.Message of
   WM_DROPFILES: WMDropFiles(Msg.wParam, Msg.hWnd);
  end;
end;

procedure TForm1.AppException(Sender: TObject; E: Exception);
begin
 If ProgBarForm.Visible then ProgBarForm.Close;
 if fSettings.Visible then fSettings.Close;
 if fExtract.Visible then fExtract.Close;

 Screen.Cursor:=crArrow;
 MessageBox(handle,PChar('LBA Package Editor have risen an exception called: "'+E.Message+'" and may be unstable. Please save all changes and restart the program as soon as possible.'),'LBA Package Editor',MB_ICONWARNING+MB_OK);
end;

//following function was for highlighting rows during dragging files from explorer,
//but I didn't magage it to work well
{function MsgThread(p: pointer): Integer;
var pt, old_pt, fl_pt, form_pt: TPoint;
    ARow, ACol: Integer;
    flCanSelect: Boolean;
    MouseBtn: Word;
begin
 With Form1 do begin
  repeat
   FileDragging:=True;
   Sleep(10);
   pt:=Mouse.CursorPos;
   form_pt:=ClientToScreen(pt);
   fl_pt:=FileList.ScreenToClient(pt);
   //Form1.Label1.Caption:=IntToStr(pt.x)+'  '+IntToStr(pt.y);

   SetCaption('InLabel',IntToStr(MouseBtn));
   If FileDragging and ((old_pt.x<>pt.x) or (old_pt.y<>pt.y)) and
    (fl_pt.x>=0) and (fl_pt.y>=0) and
    (fl_pt.x<=FileList.Width) and (fl_pt.y<=FileList.Height) //and
     then begin
    Form1.FileList.MouseToCell(fl_pt.x,fl_pt.y,ACol,ARow);
    if ARow>0 then begin
     //mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTDOWN, pt.x, pt.y, 0, 0);
     //mouse_event(MOUSEEVENTF_ABSOLUTE or MOUSEEVENTF_LEFTUP, pt.x, pt.y, 0, 0);
     Form1.FileList.Selection:=TGridRect(Rect(0,ARow,8,ARow));
     Form1.FileListSelectCell(nil,0,ARow,flCanSelect);
    end;
   end;
   old_pt:=pt;
  until 0=1;
 end;
end;}

procedure TForm1.aBlankExecute(Sender: TObject);
begin
 DisplayStruct;
end;

procedure TForm1.FileListDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var a: Integer;
    NumRect: TRect;
begin
 If ARow=0 then Exit;
 if SelectedRows[ARow] then begin
  FileList.Canvas.Brush.Color:=clSkyBlue;
  FileList.Canvas.Font.Color:=clBlack;
  FileList.Canvas.FillRect(Rect);
  FileList.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,Filelist.Cells[ACol,ARow]);
 end
 else if ARow=FileList.Selection.Top then begin
  FileList.Canvas.Brush.Color:=clWindow;
  FileList.Canvas.Font.Color:=clBlack;
  FileList.Canvas.FillRect(Rect);
  FileList.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,Filelist.Cells[ACol,ARow]);
 end;
 Case ACol of
  5:begin
   If IsNorm(DispMap[ARow]) then begin
    FileList.Canvas.Font.Color:=clGreen;
    FileList.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,'Normal');
   end
   else if IsHidden(DispMap[ARow]) then begin
    FileList.Canvas.Font.Color:=clOlive;
    FileList.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,'Hidden');
   end
   else if IsBlank(DispMap[ARow]) then begin
    FileList.Canvas.Font.Color:=clMaroon;
    NumRect:=Classes.Rect(FileList.CellRect(0,ARow).Left,Rect.Top,FileList.CellRect(8,Arow).Right,Rect.Bottom);
    FileList.Canvas.TextRect(NumRect,NumRect.Left+2,NumRect.Top+2,FileList.Cells[0,ARow]);
    NumRect.Left:=NumRect.Left+FileList.Canvas.TextWidth(FileList.Cells[0,ARow])+2;
    NumRect.Right:=FileList.CellRect(5,ARow).Right;
    If FileList.Cells[5,ARow]='Blank' then
     FileList.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,'Blank')
    else 
     FileList.Canvas.TextRect(NumRect,NumRect.Right-2-FileList.Canvas.TextWidth(FileList.Cells[5,ARow]),NumRect.Top+2,FileList.Cells[5,ARow]);
   end
   else begin
    FileList.Canvas.Font.Color:=clBlue;
    FileList.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,Filelist.Cells[5,ARow]);
   end;
  end;
  0:If Copy(FileList.Cells[0,ARow],1,1)='+' then begin
   FileList.Canvas.Brush.Color:=clSkyBlue;
   FileList.Canvas.Font.Color:=clBlack;
   //FileList.Canvas.FillRect(Rect);
   FileList.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,Filelist.Cells[0,ARow]);
  end;
  7:if not IsBlank(DispMap[ARow]) then begin
   a:=Entries[DispMap[ARow]].ExtIndex;
   If a>0 then begin
    FileList.Canvas.Font.Color:=inf_colour[a];
    FileList.Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,FileList.Cells[ACol,ARow]);
   end;
  end;
 end;
end;

procedure TForm1.aChangeOutExecute(Sender: TObject);
var ext: String;
begin
 ext:=LowerCase(ExtractFileExt(InLabel.Caption));
 dSavePack.FilterIndex:=1;
 If ext='.ile' then dSavePack.FilterIndex:=2;
 If ext='.obl' then dSavePack.FilterIndex:=3;
 If ext='.vox' then dSavePack.FilterIndex:=4;
 dSavePack.InitialDir:=LastIODir;
 dSavePack.FileName:='';
 If dSavePack.Execute then begin
  SetCaption(OutLabel,dSavePack.FileName);
  OutSpec:=True;
  Modified:=True;
  LastIODir:=ExtractFilePath(dSavePack.FileName);
 end;
 ActiveControl:=nil; 
end;

procedure TForm1.aBuildExecute(Sender: TObject);
begin
 If not OutSpec then aChangeOutExecute(Self);
 If not OutSpec then begin
  MessageBox(handle,'Output file cannot be built unless you specify it!','LBA Package Editor',MB_ICONERROR+MB_OK);
  Exit;
 end;
 SavePack(OutLabel.Caption);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 FileList.Show;
end;

procedure TForm1.aLoadInputExecute(Sender: TObject);
begin
 CheckModified;
 UnloadPack;
 dOpenPack.InitialDir:=LastIODir;
 If dOpenPack.Execute then begin
  LastIODir:=ExtractFilePath(dOpenPack.FileName);
  OpenPack(dOpenPack.FileName);
  If FileList.Visible then FileList.SetFocus;
 end;
end;

procedure SetDragType(Mode, ACol, ARow: Integer);
begin
 DragType:=dtNone;
 If SelectCount<>1 then Abort;
 case Mode of
  0:Abort;
  1:If Entries[DispMap[ARow]].Replace<>'' then DragType:=dtRepl else Abort;
  2:DragType:=dtEntry;
  3:If Entries[DispMap[ARow]].Replace<>'' then DragType:=dtRepl else DragType:=dtEntry;
  4:If ACol<=7 then DragType:=dtEntry
    else if Entries[DispMap[ARow]].Replace<>'' then DragType:=dtRepl else Abort;
 end;
end;

function Max(v1, v2: Integer): Integer;
begin
 If v1>v2 then Result:=v1 else Result:=v2;
end;

function Min(v1, v2: Integer): Integer;
begin
 If v1>v2 then Result:=v2 else Result:=v1;
end;

procedure TForm1.FileListMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var ARow, ACol: Integer;
begin
 If DoubleClick then begin
  DoubleClick:=False;
  Exit;
 end; 
 FileList.MouseToCell(X,Y,ACol,ARow);
 If Button=mbLeft then begin
  If SelectCount<>1 then NoSelect:=True;
  If not IsBlank(DispMap[ARow]) then begin
   SetDragType(fSettings.rgLmbMode.ItemIndex,ACol,ARow);
   FileList.BeginDrag(False,1);
  end;
 end;
 If Button=mbRight then begin
  If (SelectCount<=1) then begin
   FileList.Selection:=TGridRect(Rect(0,ARow,8,ARow));
   SelectCell(0,ARow,True);
  end;
  If not IsBlank(DispMap[ARow]) then begin
   SetDragType(fSettings.rgRmbMode.ItemIndex,ACol,ARow);
   FileList.BeginDrag(False,1);
  end; 
  DragPoint:=Point(x,y);
 end;
end;

procedure TForm1.FileListMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var ARow, ACol: Integer;
begin
 If (SelectCount=1) and (ssRight in Shift) then begin
  FileList.MouseToCell(X,Y,ACol,ARow);
  FileList.Selection:=TGridRect(Rect(0,ARow,8,ARow));
  SelectCell(0,ARow,True);
 end;
end;

procedure TForm1.aReplaceExecute(Sender: TObject);
var a, count: Integer;
begin
 If SelectCount<1 then Exit;
 If not IsNormalSelected then Exit;
 With dOpenReplace do begin
  If SelectCount=1 then begin
   Options:=Options-[ofAllowMultiSelect];
   Title:='Specify file to replace selected entry with';
   If Execute then begin
    LastReDir:=ExtractFilePath(FileName);
    SetReplacement(FileList.Selection.Top,FileName);
   end;
  end
  else begin
   Options:=Options+[ofAllowMultiSelect];
   Title:='Specify files to replace (mind order in "File name" box below!)';
   If Execute then begin
    If Files.Count<1 then Exit;
    LastReDir:=ExtractFilePath(Files.Strings[0]);
    count:=0;
    for a:=0 to Length(SelectedRows)-1 do
     If SelectedRows[a] and (not IsBlank(DispMap[a])) then begin
      SetReplacement(a,Files.Strings[count]);
      Inc(count);
      if count>=Files.Count then Exit;
     end; 
   end;
  end;
 end;
end;

procedure TForm1.aClearExecute(Sender: TObject);
var a: Integer;
begin
 If not (InLoaded and Displayed) then Exit;
 For a:=1 to Length(SelectedRows)-1 do
  If SelectedRows[a] and (Entries[DispMap[a]].Replace<>'')
  and not IsBlank(DispMap[a]) then begin
   Entries[DispMap[a]].Replace:='';
   FileList.Cells[8,a]:='';
   Modified:=True;
  end;
end;

procedure TForm1.aSaveProjectExecute(Sender: TObject);
begin
 dSaveProject.InitialDir:=LastOSDir;
 If dSaveProject.Execute then begin
  LastOSDir:=ExtractFilePath(dSaveProject.FileName);
  SaveProject(dSaveProject.FileName);
 end;
end;

procedure TForm1.aOpenProjectExecute(Sender: TObject);
begin
 CheckModified;
 UnloadPack;
 dOpenProject.InitialDir:=LastOSDir;
 if dOpenProject.Execute then begin
  LastOSDir:=ExtractFilePath(dOpenProject.FileName);
  OpenProject(dOpenProject.FileName);
 end;
end;

procedure TForm1.aClearAllExecute(Sender: TObject);
var a, b: Integer;
begin
 If not (InLoaded and Displayed) then Exit;
 If MessageBox(handle,'Are you sure you want to clear all replacements?','LBA archive editor',MB_ICONQUESTION+MB_YESNO)=ID_YES
 then begin
  for a:=0 to FCount-1 do
   if IsNorm(a) or IsHidden(a) then begin
    Entries[a].Replace:='';
    b:=FindRow(a);
    if b>0 then
     FileList.Cells[8,b]:='';
   end;
  Modified:=True;
 end;
end;

procedure TForm1.aSettingsExecute(Sender: TObject);
begin
 ShowSettingsDialog;
end;

procedure TForm1.FileListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var Recta: TRect;
    S: String;
begin
 If Key=46 then aClear.Execute
 else
  If ((Key=13) or (Key=113)) and (SelectCount=1) and aReplace.Enabled then begin
   DisableAll;
   Recta:=Filelist.CellRect(8,FileList.Selection.Top);
   Edit1.Left:=Recta.Left+FileList.Left+2;
   Edit1.Top:=Recta.Top+FileList.Top+2;
   Edit1.Width:=Recta.Right-Recta.Left;
   S:=Entries[DispMap[FileList.Selection.Top]].Replace;
   If Copy(S,1,1)='>' then
    Edit1.Text:='>'+FileList.Cells[0,FindRow(StrToInt(Copy(S,2,Length(S)-1)))]
   else
    Edit1.Text:=S;
   Edit1.Visible:=True;
   Edit1.SetFocus;
  end;
end;

function GetWidth(Text: String): Integer;
begin
 Result:=Form1.InLabel.Canvas.TextWidth(Text)+2;
end;

procedure TForm1.FormResize(Sender: TObject);
var adbuff, buffer: Integer;
begin
  buffer:=Trunc(Form1.Width/2.9);
  if buffer<GetWidth(InfAll.Caption) then buffer:=GetWidth(InfAll.Caption);
 InfAll.Width:=buffer;
 InfReal.Left:=buffer;
  adbuff:=Form1.Width div 6;
  if adbuff<GetWidth(InfReal.Caption) then adbuff:=GetWidth(InfReal.Caption);
  Inc(buffer,adbuff);
 InfReal.Width:=buffer-InfReal.Left;
 InfHidden.Left:=buffer;
  adbuff:=Form1.Width div 6;
  if adbuff<GetWidth(InfHidden.Caption) then adbuff:=GetWidth(InfHidden.Caption);
  Inc(buffer,adbuff);
 InfHidden.Width:=buffer-InfHidden.Left;
 InfRep.Left:=buffer;
  adbuff:=Form1.Width div 5;
  if adbuff<GetWidth(InfRep.Caption) then adbuff:=GetWidth(InfRep.Caption);
  Inc(buffer,adbuff);
 InfRep.Width:=buffer-InfRep.Left;
 InfBlank.Left:=buffer;
 InfBlank.Width:=Form1.Width-InfBlank.Left-8;
 DopasujRozmiar;
 MinimizePaths;
 EnableHint(InLabel);
 EnableHint(lb_filedesc);
 EnableHint(OutLabel);
end;

procedure TForm1.aExtractExecute(Sender: TObject);
var buf: String;
    a: Integer;
begin
 If SelectCount<1 then Exit;
 If not IsNormalSelected then Exit;
 dSaveEntry.FilterIndex:=Entries[DispMap[FileList.Selection.Top]].ExtIndex+1;
 dSaveEntry.InitialDir:=LastReDir;
 dSaveEntry.FileName:=GetExtractedSel(not fSettings.cbNoIncPack.Checked,fSettings.cbIncInfo.Checked);
 If SelectCount=1 then begin
  If dSaveEntry.Execute then begin
   LastReDir:=ExtractFilePath(dSaveEntry.FileName);
   ExtractEntry(DispMap[SelectedRow],dSaveEntry.FileName,False);
   Status1.Panels[1].Text:='Entry succesfully extracted.';
   Beep;
  end;
 end
 else begin
  buf:=SelectDir(Handle,LastReDir,'Extract selected entries to directory:');
  If buf<>'' then begin
   LastReDir:=buf;
   buf:=buf+'\'+GetExtractedName(not fSettings.cbNoIncPack.Checked,fSettings.cbIncInfo.Checked);
   ProgBarForm.ShowSpecial('Extracting...',False,True,0,FCount-1);
   for a:=1 to Length(SelectedRows)-1 do begin
    If SelectedRows[a] then begin
     ProgBarForm.UpdateLabel('Extracting...');
     ExtractEntry(DispMap[a],
      ConExtracted(buf,GetExtractedEnding(a,fSettings.cbIncInfo.Checked),a));
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
   Status1.Panels[1].Text:='Entries succesfully extracted.';
  end;
 end;
end;

procedure TForm1.aExtractPartExecute(Sender: TObject);
begin
 PartialExtract;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 If DraggingUp then begin
  if FileList.TopRow>1 then FileList.TopRow:=FileList.TopRow-1;
 end else
  if FileList.TopRow<FileList.RowCount-(Filelist.Height div FileList.DefaultRowHeight)+3 then
   FileList.TopRow:=FileList.TopRow+1;
end;

procedure TForm1.FileListMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 With FileList do begin
  aOffset.Checked:=ColWidths[1]<>0;
  aRlSize.Checked:=ColWidths[2]<>0;
  aCpSize.Checked:=ColWidths[3]<>0;
  aComp.Checked:=ColWidths[4]<>0;
  aType.Checked:=ColWidths[5]<>0;
  aExt.Checked:=ColWidths[6]<>0;
  aInfo.Checked:=ColWidths[7]<>0;
  DopasujRozmiar;
  aRepl.Checked:=ColWidths[8]<>0;
  MinimizePaths;
 end;
 NoSelect:=False;
end;

procedure TForm1.aUnloadPackExecute(Sender: TObject);
begin
 CheckModified;
 UnloadPack;
end;

procedure TForm1.aAboutExecute(Sender: TObject);
begin
 Form2:=TForm2.Create(Form1);
 try
  Form2.ShowModal;
 finally
  Form2.Free;
 end;
end;

procedure TForm1.FileListDblClick(Sender: TObject);
var Index: Integer;
begin
 case fSettings.rgDblMode.ItemIndex of
  1: aExtractExecute(self);
  2: aReplaceExecute(self);
  3: begin
      Index:=Entries[DispMap[FileList.Selection.Top]].ExtIndex;
      if ToolEnabled[Index] and (Index<>0) then
       aOpenExecute(aOpen)
      else
       case fSettings.rgNoEditMode.ItemIndex of
        1: aExtractExecute(self);
        2: aReplaceExecute(self);
        3: aOpenExecute(aOpenCommon);
       end;
     end;  
 end;
 DoubleClick:=True;
end;

procedure DopasujRozmiar;
var a, b: Integer;
begin
 With Form1, Form1.FileList do begin
  b:=0;
  for a:=0 to 6 do
   b:=b+ColWidths[a];
  if ColWidths[8]=0 then ColWidths[7]:=FileList.Width-b-29;
  ColWidths[8]:=FileList.Width-b-29-ColWidths[7];
  If ColWidths[8]<0 then begin
   ColWidths[8]:=0;
   DopasujRozmiar;
  end; 
  If ColWidths[7]<>0 then aInfo.Checked:=True;
 end;
end;

procedure TForm1.ColumnsMenuClick(Sender: TObject);
var a, b: Integer;
begin
 With FileList do begin
  If (Sender as TAction).Name='aOffset' then ColWidths[1]:=IfThen((Sender as TAction).Checked,53);
  If (Sender as TAction).Name='aRlSize' then ColWidths[2]:=IfThen((Sender as TAction).Checked,62);
  If (Sender as TAction).Name='aCpSize' then ColWidths[3]:=IfThen((Sender as TAction).Checked,52);
  If (Sender as TAction).Name='aComp' then ColWidths[4]:=IfThen((Sender as TAction).Checked,12);
  If (Sender as TAction).Name='aType' then ColWidths[5]:=IfThen((Sender as TAction).Checked,38);
  If (Sender as TAction).Name='aExt' then ColWidths[6]:=IfThen((Sender as TAction).Checked,24);
  If (Sender as TAction).Name='aInfo' then ColWidths[7]:=IfThen((Sender as TAction).Checked,170);
  If (Sender as TAction).Name='aRepl' then ColWidths[7]:=170;
  b:=0;
  for a:=0 to 7 do b:=b+ColWidths[a];
  If aRepl.Checked then ColWidths[8]:=FileList.Width-b-29 else ColWidths[8]:=0;
 end;
 DopasujRozmiar;
end;

procedure TForm1.aReloadExecute(Sender: TObject);
var a: String;
begin
 CheckModified;
 a:=InLabel.Caption;
 UnloadPack;
 OpenPack(a);
end;

procedure TForm1.aOpenRecent(Sender: TObject);
begin
 CheckModified;
 UnloadPack;
 OpenParam((Sender as TMenuItem).Caption);
end;

procedure EditError(msg: String);
begin
 MessageBox(Form1.Handle,PChar(msg),'LBA Package Editor',MB_ICONERROR+MB_OK);
 Form1.Edit1.SetFocus;
 Abort;
end;

procedure EndReplaceEditing;
var a: Char;
    b: String;
    c: Integer;
    Match: Boolean;
begin
 If not Form1.Edit1.Visible then Exit;
 If Length(Form1.Edit1.Text)>0 then begin
  a:=LowerCase(Form1.Edit1.Text[1])[1];
  If (a<>'>') and ((a<'a') or (a>'z')) then
   EditError('First character must be ">" or a drive letter.');
  If a='>' then begin
   b:=Copy(Form1.Edit1.Text,2,Length(Form1.Edit1.Text)-1);
   for c:=1 to Length(b) do
    If (b[c]<'0') or (b[c]>'9') then
     EditError('Index must be an unsigned integer.');
   If Length(b)>8 then SetLength(b,8);
   Match:=False;
   for c:=1 to Form1.FileList.RowCount-1 do
    If b=Form1.FileList.Cells[0,c] then begin Match:=True; Break; end;
   If not Match then EditError('There is no entry with such index.');
   c:=DispMap[c];
   If IsBlank(c) then
    EditError('Specified index leads to a blank entry.');
   If IsHidden(c) then
    EditError('Specified index leads to a hidden entry. You cannot replace entries with hidden ones.');
   SetReplacement(Form1.FileList.Selection.Top,'>'+IntToStr(c));
   Form1.Edit1.Visible:=False;
   EnableAll;
   Exit;
  end;
 end;
 SetReplacement(Form1.FileList.Selection.Top,Form1.Edit1.Text);
 Form1.Edit1.Visible:=False;
 EnableAll;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
 EndReplaceEditing;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 If Key=#27 then begin
  Edit1.Visible:=False;
  EnableAll;
 end;
 If (Key=#27) or (Key=#13) then begin
  Key:=#0;
  Form1.FileList.SetFocus;
 end;
end;

procedure TForm1.EmptyActionExecute(Sender: TObject);
begin
 //
end;

procedure TForm1.aExitExecute(Sender: TObject);
begin
 Form1.Close
end;

procedure TForm1.aConfigureExecute(Sender: TObject);
begin
 ToolsForm.ShowModal;
end;

procedure TForm1.ToolExecute(Sender: TObject);
var S: String;
    index: Integer;
begin
 index:=mTools.IndexOf(Sender as TMenuItem);
 S:='"'+ToolPaths[index]+'"';
 If ToolUseMenu[index] then S:=S+' "'+ToolParams[index]+'"';
 WinExec(PChar(S),sw_Normal);
end;

procedure TForm1.aOpenExecute(Sender: TObject);
var buf, FileParams, s: String;
    a, b, Index: Integer;
    FileNames: array of String;
begin
 If SelectCount<1 then Exit;
 If (SelectCount>1) and not CheckSameEditors then Exit;
 If not IsNormalSelected then Exit;
 SetLength(FileNames,SelectCount);
 If ((Sender as TAction).Name='aOpen') then
  Index:=Entries[DispMap[GetFirstSelected]].ExtIndex
 else
  Index:=0;
 If FileExists(ToolPaths[Index]) then begin
  CreateDir(TempDir);
  If DirectoryExists(TempDir) then begin
   b:=0;
   for a:=1 to FileList.RowCount-1 do
    If SelectedRows[a] then begin
     FileNames[b]:=TempDir+'\'+GetExtracted(a);
     ExtractEntry(DispMap[a],FileNames[b],False);
     Inc(b);
     If b>=SelectCount then Break;
    end;

   tutaj wstawiæ

   FileParams:='';
   for a:=0 to High(FileNames) do
    FileParams:=FileParams+' "'+FileNames[a]+'"';
   If ToolUseEntry[Index] then buf:=ToolParams[Index] else buf:='';
   If SelectCount=1 then RunTool(ToolPaths[Index],FileNames[0],buf,DispMap[FileList.Selection.Top])
   else begin
    s:='"'+ToolPaths[Index]+'"';
    if buf<>'' then s:=s+' "'+buf+'"';
    s:=s+FileParams;
    WinExec(PChar(s),SW_SHOWNORMAL);
   end;
   EnableReplace(Index);
  end
  else
   MessageBox(Handle,PChar('Directory "'+TempDir+'" could not be created.'),'LBA Package Editor',MB_ICONERROR+MB_OK);
 end
 else
  MessageBox(Handle,PChar(ToolNames[Index]+' could not be found at specified path.'),'LBA Package Editor',MB_ICONERROR+MB_OK);
end;

procedure TForm1.bSameClick(Sender: TObject);
begin
 SetCaption(OutLabel,InLabel.Caption);
 OutSpec:=True;
 ActiveControl:=nil;
end;

procedure TForm1.ThdTimerTimer(Sender: TObject);
var a, b: Integer;
    ModTemp: Boolean;
begin
 ThdTimer.Enabled:=False;
 for a:=0 to Length(ThdParams)-1 do
  If not (ThdParams[a].Running or ThdParams[a].Unused) then begin
   If ThdParams[a].FileChanged then begin
    DialogForm:=TDialogForm.Create(Form1);
    try
     DialogForm.Label1.Caption:='The date/time of file '+ExtractFileName(ThdParams[a].FilePath)+' has changed. What to do with it?';
     DialogForm.ShowModal;
     case DialogForm.ModalResult of
      mrOk: begin
             ModTemp:=Modified;
             SaveProject(TempDir+'\temp.lpp');
             for b:=0 to FCount-1 do
              if IsNorm(b) or IsHidden(b) then
               Entries[b].Replace:='';
             SetReplacement(FindRow(ThdParams[a].EntryIndex),ThdParams[a].FilePath);
             SavePack(InLabel.Caption);
             OpenProject(TempDir+'\temp.lpp');
             Modified:=ModTemp;
            end;
      mryes: begin
              SetReplacement(FindRow(ThdParams[a].EntryIndex),ThdParams[a].FilePath);
              aBuild.Execute;
             end;
      mrNo: SetReplacement(FindRow(ThdParams[a].EntryIndex),ThdParams[a].FilePath);
     end;
    finally
     DialogForm.Free;
     //DialogForm:=nil;
    end;
   end;
   ThdParams[a].Unused:=True;
   EnableReplace(Entries[DispMap[FileList.Selection.Top]].ExtIndex);
  end;
 ThdTimer.Enabled:=True;
end;

procedure TForm1.aExtractTempExecute(Sender: TObject);
var buf, ext: String;
    a: Integer;
begin
 If not IsNormalSelected then Exit;
 CreateDir(TempDir);
 If DirectoryExists(TempDir) then begin
  buf:=ExtractFileName(InLabel.Caption);
  buf:=Copy(buf,1,Length(Buf)-4);
  ProgBarForm.ShowSpecial('Extracting...',False,True,0,FCount-1);
  for a:=1 to Length(SelectedRows)-1 do begin
   If SelectedRows[a] then begin
    ProgBarForm.UpdateLabel('Extracting...');
    ext:=FileList.Cells[6,a];
    If (ext='') or (ext='   ') then ext:='lun';
     ExtractEntry(DispMap[a],TempDir+'\'+buf+GetNumber(FileList.Cells[0,a])+'.'+ext);
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
  Status1.Panels[1].Text:='Entries succesfully extracted.';
 end
 else
  MessageBox(Handle,PChar('Directory "'+TempDir+'" could not be created.'),'LBA Package Editor',MB_ICONERROR+MB_OK);
end;

procedure TForm1.aReplaceTempExecute(Sender: TObject);
var buf, ext: String;
    a: Integer;
begin
 If not IsNormalSelected then Exit;
 buf:=ExtractFileName(InLabel.Caption);
 buf:=Copy(buf,1,Length(Buf)-4);
 for a:=0 to Length(SelectedRows)-1 do
  If SelectedRows[a] and
  ((FileList.Cells[5,a]='Normal') or (FileList.Cells[5,a]='Hidden')) then begin
   ext:=FileList.Cells[6,a];
   If (ext='') or (ext='   ') then ext:='lun';
   SetReplacement(a,TempDir+'\'+buf+GetNumber(FileList.Cells[0,a])+'.'+ext);
  end;
end;

procedure TForm1.aClearOpenedExecute(Sender: TObject);
var a: Integer;
begin
 For a:=0 to Length(ThdParams)-1 do
  If ThdParams[a].Running
  and AnsiSameText(ThdParams[a].FilePath,TempDir+'\'+GetExtractedSel) then begin
   ThdParams[a].Terminate:=True;
   Break;
  end;
end;

{procedure TForm1.dOpenPackFilePreview(Sender: TObject; const Filename: string;
 Canvas: TCanvas; const Rect: TRect; Progress: TProgressEvent; var Handled: Boolean);
begin
 Canvas.TextOut(2,2,FileName);
 Handled:=True;
end; }

end.
