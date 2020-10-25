//******************************************************************************
// Little Big Architect - editing grid, brick and layout files containing
//                        rooms in Little Big Adventure 1 & 2
//
// ProgBar unit (used in both Builder and Factory).
// Contains progress bar displaying routines.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit ProgBar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

type
  TProgBarForm = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Image1: TImage;
    btStop: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
   procedure ShowSpecial(Caption: String; CursorChange: Boolean;
    StopBtn: Boolean; Min, Max: Integer);
   procedure UpdateBar(Val: Integer);
   procedure UpdateLabel(NewText: String);
  end;

var
  ProgBarForm: TProgBarForm;
  AMin: Integer = 0;
  AMax: Integer = 100;
  Pos: Integer = 0;
  PixPos: Integer = 0;
  AText: PChar;
  TextL: Integer;  // length of the text
  TextPL: Integer; // pixel length
  TextR: TRect;    // text rect
  IntReq: Boolean = False;

implementation

{$R *.dfm}

uses LBAPackEd1;

procedure TProgBarForm.ShowSpecial(Caption: String; CursorChange: Boolean;
 StopBtn: Boolean; Min, Max: Integer);
begin
 If CursorChange then Screen.Cursor:=crHourGlass;
 Image1.Canvas.Brush.Color:=clBtnFace;
 Image1.Canvas.FillRect(Rect(0,0,Image1.Width,Image1.Height));
 Image1.Canvas.Brush.Style:=bsClear;
 AMin:=Min;
 AMax:=Max;
 Pos:=0;
 PixPos:=0;
 AText:=PChar(Caption);
 TextPL:=ProgBarForm.Image1.Canvas.TextWidth(Caption);
 TextL:=Length(Caption);
 TextR:=Rect((Image1.Width-TextPL) div 2,1,TextPL,Image1.Canvas.TextHeight(Caption)+1);
 Image1.Canvas.Font.Color:=clBlack;
 Image1.Canvas.TextOut(TextR.Left,1,Caption);
 Image1.Canvas.Font.Color:=clWhite;
 btStop.Visible:=StopBtn;
 If StopBtn then Bevel1.Height:=90 else Bevel1.Height:=57;
 Form1.Enabled:=False;
 IntReq:=False;
 Show;
 Application.ProcessMessages;
end;

procedure TProgBarForm.UpdateBar(Val: Integer);
var NewPix, a: Integer;
begin
 If Pos=Val then Exit;
 NewPix:=IfThen(AMax-AMin>0,Round(((Val-AMin)*317)/(AMax-AMin)));
 If NewPix=PixPos then Exit;
 for a:=0 to 17 do begin
  Image1.Canvas.Pen.Color:=$ff9090-a*$070707;
  Image1.Canvas.MoveTo(PixPos,a);
  Image1.Canvas.LineTo(NewPix,a);
 end;
 If NewPix>=TextR.Left then begin
  If TextR.Right-TextR.Left<TextPL then TextR.Right:=NewPix;
  DrawText(Image1.Canvas.Handle,AText,TextL,TextR,DT_NOPREFIX);
 end;
 Pos:=Val;
 PixPos:=NewPix;
 Application.ProcessMessages;
end;

procedure TProgBarForm.UpdateLabel(NewText: String);
var temp: Integer;
begin
 if AText=PChar(NewText) then Exit;
 temp:=Pos;
 ShowSpecial(NewText,False,btStop.Visible,AMin,AMax);
 UpdateBar(temp);
end;

procedure TProgBarForm.FormCreate(Sender: TObject);
begin
 DoubleBuffered:=True;
end;

procedure TProgBarForm.btStopClick(Sender: TObject);
begin
 IntReq:=True;
end;

procedure TProgBarForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Screen.Cursor:=crDefault;
 Form1.Enabled:=True;
end;

end.
