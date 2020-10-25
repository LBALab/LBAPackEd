object ProgBarForm: TProgBarForm
  Left = 196
  Top = 101
  AutoSize = True
  BorderStyle = bsNone
  Caption = 'ProgBarForm'
  ClientHeight = 90
  ClientWidth = 353
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 353
    Height = 90
    Style = bsRaised
  end
  object Bevel2: TBevel
    Left = 16
    Top = 18
    Width = 321
    Height = 21
  end
  object Image1: TImage
    Left = 18
    Top = 20
    Width = 317
    Height = 17
  end
  object btStop: TButton
    Left = 120
    Top = 53
    Width = 113
    Height = 25
    Caption = 'Stop'
    TabOrder = 0
    OnClick = btStopClick
  end
end
