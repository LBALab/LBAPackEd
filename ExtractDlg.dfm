object fExtract: TfExtract
  Left = 224
  Top = 102
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Extract entries...'
  ClientHeight = 376
  ClientWidth = 553
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label4: TLabel
    Left = 280
    Top = 120
    Width = 249
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 
      'Note: if you choose any blank entries to be extracted, they will' +
      ' be skipped.'
    WordWrap = True
  end
  object Button1: TButton
    Left = 152
    Top = 344
    Width = 113
    Height = 25
    Caption = 'Extract'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 280
    Top = 344
    Width = 115
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 249
    Height = 145
    Caption = 'Extract entries...'
    TabOrder = 2
    object Label3: TLabel
      Left = 176
      Top = 65
      Width = 9
      Height = 13
      Caption = 'to'
    end
    object Label6: TLabel
      Left = 32
      Top = 128
      Width = 94
      Height = 13
      Caption = 'Example: 3,6,9-14,1'
    end
    object rbExtAll: TRadioButton
      Left = 8
      Top = 16
      Width = 41
      Height = 17
      Caption = 'All'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbExtAllClick
    end
    object rbWithIndex: TRadioButton
      Left = 8
      Top = 64
      Width = 105
      Height = 17
      Caption = 'With indexes: from'
      TabOrder = 1
      OnClick = rbExtAllClick
    end
    object eFrom: TEdit
      Left = 120
      Top = 63
      Width = 49
      Height = 21
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 2
      Text = '1'
      OnChange = eCustomChange
    end
    object eTo: TEdit
      Left = 192
      Top = 63
      Width = 49
      Height = 21
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 3
      Text = '1'
      OnChange = eCustomChange
    end
    object rbCustom: TRadioButton
      Left = 8
      Top = 89
      Width = 121
      Height = 17
      Caption = 'With custom indexes:'
      TabOrder = 4
      OnClick = rbExtAllClick
    end
    object eCustom: TEdit
      Left = 24
      Top = 106
      Width = 217
      Height = 21
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 5
      OnChange = eCustomChange
    end
    object rbSelected: TRadioButton
      Left = 8
      Top = 40
      Width = 73
      Height = 17
      Caption = 'Selected'
      TabOrder = 6
    end
  end
  object rgButOnly: TRadioGroup
    Left = 264
    Top = 8
    Width = 145
    Height = 97
    Caption = '...but only:'
    ItemIndex = 0
    Items.Strings = (
      'All'
      'With EVEN indexes'
      'With ODD indexes')
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 240
    Top = 232
    Width = 305
    Height = 97
    Caption = 'And give them extensions:'
    TabOrder = 4
    object rExt0: TRadioButton
      Left = 16
      Top = 19
      Width = 233
      Height = 17
      Caption = 'As they are known (check the "ext" column) '
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rExt0Click
    end
    object rExt1: TRadioButton
      Left = 16
      Top = 43
      Width = 89
      Height = 17
      Caption = 'One of known:'
      TabOrder = 1
      OnClick = rExt0Click
    end
    object rExt2: TRadioButton
      Left = 16
      Top = 67
      Width = 73
      Height = 17
      Caption = 'Custom:'
      TabOrder = 2
      OnClick = rExt0Click
    end
    object cExt: TComboBoxEx
      Left = 112
      Top = 39
      Width = 185
      Height = 22
      AutoCompleteOptions = [acoAutoAppend, acoUpDownKeyDropsList, acoRtlReading]
      ItemsEx = <
        item
          Caption = 'lun (unknown file)'
          ImageIndex = 19
          SelectedImageIndex = 19
        end
        item
          Caption = 'lim (LBA image)'
          ImageIndex = 20
          SelectedImageIndex = 20
        end
        item
          Caption = 'pal (palette)'
          ImageIndex = 21
          SelectedImageIndex = 21
        end
        item
          Caption = 'lbt (LBA text file)'
          ImageIndex = 22
          SelectedImageIndex = 22
        end
        item
          Caption = 'lsp (LBA sprite)'
          ImageIndex = 23
          SelectedImageIndex = 23
        end
        item
          Caption = 'lsr (LBA Raw sprite)'
          ImageIndex = 24
          SelectedImageIndex = 24
        end
        item
          Caption = 'lm1 (LBA 1 3D model)'
          ImageIndex = 25
          SelectedImageIndex = 25
        end
        item
          Caption = 'lm2 (LBA 2 3D model)'
          ImageIndex = 26
          SelectedImageIndex = 26
        end
        item
          Caption = 'lfn (LBA font file)'
          ImageIndex = 27
          SelectedImageIndex = 27
        end
        item
          Caption = 'wav (Riff wave file)'
          ImageIndex = 28
          SelectedImageIndex = 28
        end
        item
          Caption = 'voc (Creative voice file)'
          ImageIndex = 29
          SelectedImageIndex = 29
        end
        item
          Caption = 'smk (Smacker movie)'
          ImageIndex = 30
          SelectedImageIndex = 30
        end
        item
          Caption = 'xmi (XMidi file)'
          ImageIndex = 31
          SelectedImageIndex = 31
        end
        item
          Caption = 'anm (LBA animation file)'
          ImageIndex = 32
          SelectedImageIndex = 32
        end
        item
          Caption = 'gif (Graphics interchange format)'
          ImageIndex = 33
          SelectedImageIndex = 33
        end
        item
          Caption = 'lsh (LBA shape file)'
          ImageIndex = 34
          SelectedImageIndex = 34
        end
        item
          Caption = 'ls1 (LBA 1 scene)'
          ImageIndex = 35
          SelectedImageIndex = 35
        end
        item
          Caption = 'ls2 (LBA 2 scene)'
          ImageIndex = 36
          SelectedImageIndex = 36
        end
        item
          Caption = 'brk (LBA brick file)'
          ImageIndex = 37
          SelectedImageIndex = 37
        end
        item
          Caption = 'bl1 (LBA 1 layouts library)'
          ImageIndex = 38
          SelectedImageIndex = 38
        end
        item
          Caption = 'bl2 (LBA 2 layouts library)'
          ImageIndex = 39
          SelectedImageIndex = 39
        end
        item
          Caption = 'gr1 (LBA 1 grid file)'
          ImageIndex = 40
          SelectedImageIndex = 40
        end
        item
          Caption = 'gr2 (LBA 2 grid file)'
          ImageIndex = 41
          SelectedImageIndex = 41
        end
        item
          Caption = 'grf (LBA 2 grid fragment'
          ImageIndex = 42
          SelectedImageIndex = 42
        end
        item
          Caption = 'pcx (ZSoft paintbrush)'
          ImageIndex = 43
          SelectedImageIndex = 43
        end>
      Style = csExDropDownList
      ItemHeight = 16
      TabOrder = 3
      OnChange = eNameChange
      Images = Form1.Images
      DropDownCount = 25
    end
    object eExt: TEdit
      Left = 112
      Top = 64
      Width = 33
      Height = 21
      Ctl3D = True
      MaxLength = 3
      ParentCtl3D = False
      TabOrder = 4
      OnChange = eNameChange
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 160
    Width = 537
    Height = 65
    Caption = 'Extract to directory:'
    TabOrder = 5
    object Label2: TLabel
      Left = 24
      Top = 44
      Width = 213
      Height = 13
      Caption = 'If the directory doesn'#39't exist, it will be created.'
    end
    object eDir: TEdit
      Left = 16
      Top = 20
      Width = 489
      Height = 21
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
    end
    object StaticText1: TStaticText
      Left = 503
      Top = 20
      Width = 19
      Height = 21
      AutoSize = False
      BevelEdges = [beTop, beRight, beBottom]
      BevelInner = bvLowered
      BevelKind = bkTile
      TabOrder = 2
    end
    object bDir: TButton
      Left = 503
      Top = 22
      Width = 17
      Height = 17
      Caption = '...'
      TabOrder = 1
      OnClick = bDirClick
    end
  end
  object cbSkipRep: TCheckBox
    Left = 424
    Top = 48
    Width = 129
    Height = 17
    Caption = 'Skip repeated entries'
    TabOrder = 6
  end
  object GroupBox4: TGroupBox
    Left = 8
    Top = 232
    Width = 225
    Height = 97
    Caption = 'Name extracted entries:'
    TabOrder = 7
    object lSample: TLabel
      Left = 8
      Top = 56
      Width = 70
      Height = 13
      Caption = 'Sample name: '
    end
    object eName: TEdit
      Left = 8
      Top = 16
      Width = 209
      Height = 21
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      OnChange = eNameChange
    end
    object cbIncInfo: TCheckBox
      Left = 112
      Top = 40
      Width = 105
      Height = 17
      Caption = 'Include entry info'
      TabOrder = 1
      OnClick = eNameChange
    end
    object stName: TStaticText
      Left = 8
      Top = 72
      Width = 209
      Height = 17
      AutoSize = False
      BevelKind = bkTile
      TabOrder = 2
    end
  end
end
