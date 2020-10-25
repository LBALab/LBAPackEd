object Form2: TForm2
  Left = 195
  Top = 103
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 362
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  DesignSize = (
    394
    362)
  PixelsPerInch = 96
  TextHeight = 16
  object Shape1: TShape
    Left = 1
    Top = 3
    Width = 392
    Height = 358
    Brush.Color = clSkyBlue
    Brush.Style = bsDiagCross
    Pen.Color = clWhite
    Shape = stRoundRect
  end
  object Label6: TLabel
    Left = 40
    Top = 16
    Width = 305
    Height = 25
    Alignment = taCenter
    AutoSize = False
    Caption = 'LBA Package Editor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 40
    Top = 48
    Width = 305
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'i.e. Editor for Little Big Adventure'#39's package files'
    Transparent = True
  end
  object Label5: TLabel
    Left = 40
    Top = 64
    Width = 305
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'successor of LBA HQR Manager'
    Transparent = True
  end
  object Label12: TLabel
    Left = 40
    Top = 80
    Width = 305
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'version 0.01 beta'
    Transparent = True
  end
  object Label3: TLabel
    Left = 40
    Top = 104
    Width = 305
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Written by Zink'
    Transparent = True
  end
  object Label7: TLabel
    Left = 40
    Top = 120
    Width = 305
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'also known as kakadudu'
    Transparent = True
  end
  object Label8: TLabel
    Left = 40
    Top = 144
    Width = 305
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Suggestions? Opinions? Ideas?'
    Transparent = True
  end
  object Label4: TLabel
    Left = 40
    Top = 160
    Width = 305
    Height = 16
    Cursor = crHandPoint
    Alignment = taCenter
    AutoSize = False
    Caption = 'zink@poczta.onet.pl'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
    OnMouseDown = Label4MouseDown
    OnMouseUp = Label4MouseUp
  end
  object Label9: TLabel
    Left = 40
    Top = 184
    Width = 305
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'You can download the latest version from'
    Transparent = True
  end
  object Label10: TLabel
    Left = 40
    Top = 200
    Width = 305
    Height = 16
    Cursor = crHandPoint
    Alignment = taCenter
    AutoSize = False
    Caption = 'www.emeraldmoon.prv.pl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
    OnMouseDown = Label10MouseDown
    OnMouseUp = Label10MouseUp
  end
  object Label1: TLabel
    Left = 8
    Top = 256
    Width = 377
    Height = 49
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Thanks to:'#13'Alexandre Fontoura - for beta testing and tons of sug' +
      'gestions ;)'#13'And everyone who contributed to LBA File Information' +
      ' Project'
    Transparent = True
    WordWrap = True
  end
  object Label11: TLabel
    Left = 16
    Top = 232
    Width = 193
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = 'Entries descriptions taken from'
    Transparent = True
    WordWrap = True
  end
  object Label13: TLabel
    Left = 208
    Top = 232
    Width = 163
    Height = 16
    Cursor = crHandPoint
    Caption = 'LBA File Information Project'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
    OnMouseDown = Label13MouseDown
    OnMouseUp = Label13MouseUp
  end
  object Button2: TButton
    Left = 145
    Top = 323
    Width = 97
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
end
