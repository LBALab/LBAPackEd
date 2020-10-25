object DialogForm: TDialogForm
  Left = 196
  Top = 102
  BorderStyle = bsDialog
  Caption = 'LBA Package Editor'
  ClientHeight = 158
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 433
    Height = 29
    AutoSize = False
    Caption = 'The date/time of file XXX has changed. What to do with it?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Label2: TLabel
    Left = 16
    Top = 48
    Width = 441
    Height = 29
    AutoSize = False
    Caption = 
      'Note that if you choose only adding to replacements and option t' +
      'o delete temp files is checked, the file will be deleted on prog' +
      'ram close. '
    WordWrap = True
  end
  object Button1: TButton
    Left = 8
    Top = 88
    Width = 225
    Height = 25
    Caption = 'Recompile current INPUT package with it'
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 120
    Width = 225
    Height = 25
    Caption = 'Recompile current OUTPUT package with it'
    ModalResult = 6
    TabOrder = 2
  end
  object Button3: TButton
    Left = 240
    Top = 104
    Width = 137
    Height = 25
    Caption = 'Only add to replacements'
    ModalResult = 7
    TabOrder = 3
  end
  object Button4: TButton
    Left = 384
    Top = 104
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 0
  end
end
