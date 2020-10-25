unit Hint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  THintLabel = class(THintWindow)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string;
      AData: Pointer): TRect; override;
  end;

  THintList = class(THintWindow)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    function CalcHintRect(MaxWidth: Integer; const AHint: string;
      AData: Pointer): TRect; override;
    procedure ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer); override;
  end;

procedure SetCaption(target: TLabel; text: String);
procedure EnableHint(target: TLabel);

implementation

uses Info;

constructor THintLabel.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 Canvas.Font.Size:=10;
 Canvas.Font.Name:='MS Sans Serif';
end;

procedure THintLabel.Paint;
var R: TRect;
begin
 R := ClientRect;
 Inc(R.Left, 2);
 Canvas.Font.Color := Screen.HintFont.Color;
 DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
   DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
end;

function THintLabel.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  Result := Rect(0, 0, MaxWidth, 0);
  DrawText(Canvas.Handle, PChar(AHint), -1, Result, DT_CALCRECT or DT_LEFT or
    DT_WORDBREAK or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly);
  Inc(Result.Right, 6);
  Dec(Result.Bottom, 1);
end;

constructor THintList.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 Canvas.Font.Size:=8;
 Canvas.Font.Name:='MS Sans Serif';
end;

procedure THintList.Paint;
var R: TRect;
begin
 R := ClientRect;
 Inc(R.Left, 2);
 Inc(R.Top, 2);
 DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
   DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
end;

function THintList.CalcHintRect(MaxWidth: Integer; const AHint: string; AData: Pointer): TRect;
begin
  Result := Rect(0, 0, MaxWidth, 0);
  DrawText(Canvas.Handle, PChar(AHint), -1, Result, DT_CALCRECT or DT_LEFT or
    DT_WORDBREAK or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly);
  Inc(Result.Right, 6);
  Inc(Result.Bottom, 1);
end;

procedure THintList.ActivateHintData(Rect: TRect; const AHint: string; AData: Pointer);
begin
 If (Integer(AData^)>=0) and (Integer(AData^)<=High(inf_colour)) then
  Canvas.Font.Color:=inf_colour[Integer(AData^)]
 else
  Canvas.Font.Color:=Screen.HintFont.Color;
 inherited;
end;

procedure SetCaption(target: TLabel; text: String);
begin
 target.Caption:=text;
 target.Hint:=text;
 EnableHint(target);
end;

procedure EnableHint(target: TLabel);
begin
 target.ShowHint:=target.Canvas.TextWidth(target.Caption)>target.Width;
end;

end.
