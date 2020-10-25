object ToolsForm: TToolsForm
  Left = 198
  Top = 102
  BorderStyle = bsDialog
  Caption = 'Configure tools'
  ClientHeight = 447
  ClientWidth = 559
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label18: TLabel
    Left = 200
    Top = 88
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object Label19: TLabel
    Left = 200
    Top = 136
    Width = 25
    Height = 13
    Caption = 'Path:'
  end
  object Label20: TLabel
    Left = 201
    Top = 184
    Width = 104
    Height = 13
    Caption = 'Additional parameters:'
  end
  object Label1: TLabel
    Left = 272
    Top = 48
    Width = 225
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'If you cannot enable a tool, then it means that you left "Name" ' +
      'or "Path" field empty.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 248
    Top = 16
    Width = 265
    Height = 13
    Caption = 'Don'#39't forget to enable the tool after setting it'#39's properties!'
  end
  object ePath: TEdit
    Left = 200
    Top = 152
    Width = 336
    Height = 21
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 3
    OnChange = eNameChange
  end
  object StaticText1: TStaticText
    Left = 534
    Top = 152
    Width = 19
    Height = 21
    AutoSize = False
    BevelEdges = [beTop, beRight, beBottom]
    BevelInner = bvLowered
    BevelKind = bkTile
    TabOrder = 8
  end
  object Button4: TButton
    Left = 456
    Top = 417
    Width = 97
    Height = 25
    Caption = 'Close'
    ModalResult = 1
    TabOrder = 0
  end
  object ExtList: TListView
    Left = 8
    Top = 8
    Width = 185
    Height = 433
    Checkboxes = True
    Columns = <
      item
        Width = 60
      end
      item
        Width = 120
      end>
    ColumnClick = False
    HideSelection = False
    Items.Data = {
      EB0300001900000013000000FFFFFFFFFFFFFFFF0100000000000000012A1055
      6E6976657273616C20656469746F7214000000FFFFFFFFFFFFFFFF0100000000
      000000036C696D094C424120696D61676515000000FFFFFFFFFFFFFFFF010000
      00000000000370616C0770616C6574746516000000FFFFFFFFFFFFFFFF010000
      0000000000036C62740D4C424120746578742066696C6517000000FFFFFFFFFF
      FFFFFF0100000000000000036C73700A4C42412073707269746518000000FFFF
      FFFFFFFFFFFF0100000000000000036C73720E4C424120726177207370726974
      6519000000FFFFFFFFFFFFFFFF0100000000000000036C6D310E4C4241203120
      3344206D6F64656C1A000000FFFFFFFFFFFFFFFF0100000000000000036C6D32
      0E4C42412032203344206D6F64656C1B000000FFFFFFFFFFFFFFFF0100000000
      000000036C666E084C424120666F6E741C000000FFFFFFFFFFFFFFFF01000000
      0000000003776176095269666620776176651D000000FFFFFFFFFFFFFFFF0100
      00000000000003766F630E437265617469766520766F6963651E000000FFFFFF
      FFFFFFFFFF010000000000000003736D6B0D536D61636B6572206D6F7669651F
      000000FFFFFFFFFFFFFFFF010000000000000003786D6906582D6D6964692000
      0000FFFFFFFFFFFFFFFF010000000000000003616E6D09616E696D6174696F6E
      21000000FFFFFFFFFFFFFFFF0100000000000000036769660E47726170686963
      7320696D61676522000000FFFFFFFFFFFFFFFF0100000000000000036C736809
      4C424120736861706523000000FFFFFFFFFFFFFFFF0100000000000000036C73
      310B4C42412031207363656E6524000000FFFFFFFFFFFFFFFF01000000000000
      00036C73320B4C42412032207363656E6525000000FFFFFFFFFFFFFFFF010000
      00000000000362726B0E4C424120627269636B2066696C6526000000FFFFFFFF
      FFFFFFFF010000000000000003626C31154C42412031206C61796F757473206C
      69627261727927000000FFFFFFFFFFFFFFFF010000000000000003626C32154C
      42412032206C61796F757473206C69627261727928000000FFFFFFFFFFFFFFFF
      0100000000000000036772310F4C4241203120677269642066696C6529000000
      FFFFFFFFFFFFFFFF0100000000000000036772320F4C42412032206772696420
      66696C652A000000FFFFFFFFFFFFFFFF010000000000000003677266134C4241
      2032206772696420667261676D656E742B000000FFFFFFFFFFFFFFFF01000000
      0000000003706378105A536F6674207061696E746272757368FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFF2A00FFFF}
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    SmallImages = Form1.Images
    TabOrder = 1
    ViewStyle = vsReport
    OnChange = ExtListChange
    OnClick = ExtListClick
  end
  object eName: TEdit
    Left = 200
    Top = 104
    Width = 353
    Height = 21
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 2
    OnChange = eNameChange
  end
  object Button1: TButton
    Left = 534
    Top = 154
    Width = 17
    Height = 17
    Caption = '...'
    TabOrder = 4
    OnClick = Button1Click
  end
  object eParams: TEdit
    Left = 200
    Top = 200
    Width = 353
    Height = 21
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 5
    OnChange = eNameChange
  end
  object cbUseMenu: TCheckBox
    Left = 208
    Top = 232
    Width = 241
    Height = 17
    Caption = 'Use parameters when running from tools menu'
    TabOrder = 6
    OnClick = cbUseMenuClick
  end
  object cbUseEntry: TCheckBox
    Left = 208
    Top = 256
    Width = 241
    Height = 17
    Caption = 'Use parameters when opening an entry'
    TabOrder = 7
    OnClick = cbUseMenuClick
  end
  object OpenProg: TOpenDialog
    Ctl3D = False
    Filter = 'Executables (*.exe, *.com, *.pif, *.bat)|*.exe;*.com;*.pif;*.bat'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing, ofDontAddToRecent]
    Left = 528
  end
end
