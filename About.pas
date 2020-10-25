//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// About unit.
// Contains About dialog and routines for clickable links.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellApi;

type
  TForm2 = class(TForm)
    Button2: TButton;
    Shape1: TShape;
    Label6: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    procedure Label10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label10MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Label13MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label13MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses LBAPackEd1;

{$R *.dfm}

procedure TForm2.Label10MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Label10.Font.Color:=clYellow;
 Label10.Repaint;
 ShellExecute(Handle,'open','mailto:zink@poczta.onet.pl',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm2.Label10MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Label10.Font.Color:=clBlue;
end;

procedure TForm2.Label4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Label4.Font.Color:=clYellow;
 Label4.Repaint;
 ShellExecute(Handle,'open','http://www.emeraldmoon.prv.pl',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm2.Label4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Label4.Font.Color:=clBlue;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 Label12.Caption:='version '+VNum;
end;

procedure TForm2.Label13MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Label13.Font.Color:=clYellow;
 Label13.Repaint;
 ShellExecute(Handle,'open','http://el-muerte.student.utwente.nl/lba/forum/showthread.php?t=7488',nil,nil,SW_SHOWNORMAL);
end;

procedure TForm2.Label13MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Label13.Font.Color:=clBlue;
end;

end.
