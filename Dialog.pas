//******************************************************************************
// LBA Package Editor - editing hqr, ile, obl, vox packages from
//                      Little Big Adventure 1 & 2
//
// Dialog unit.
// Contains dialog window displayed when you modify an entry with a tool.
//
// Copyright (C) Zink
// e-mail: zink@poczta.onet.pl
// See the GNU General Public License (License.txt) for details.
//******************************************************************************

unit Dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TDialogForm = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DialogForm: TDialogForm;

implementation

{$R *.dfm}

procedure TDialogForm.FormShow(Sender: TObject);
begin
 Beep;
end;

end.
