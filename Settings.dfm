object fSettings: TfSettings
  Left = 194
  Top = 102
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Settings'
  ClientHeight = 366
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001000800680500001600000028000000100000002000
    0000010008000000000000010000000000000000000000010000000100002426
    0C00949A4C00243694004462A400545A2C002C3EAC00343E44008C9AAC00443E
    1C004462CC003C52AC00C4CED400645E5C005C92E4002C321C007C8684004C4A
    34003C56C400344A8400DCDE74007C7E34003C3A2C00747AA400545644002C4A
    AC005C7AD400443A1C00A4A6AC0044462C0074928C003C5EBC0094B6E4003C32
    1C006C8694003C5EC4003C4E9C003C4EBC00A4AEAC002C3E9C00443E2C00847E
    5C0054523C00344AB4005C7EEC00646634003C52BC00444A3C00F4EE8C005C62
    54002C2A1C004C66B4004C563C004466DC004C627C0034322400848A8C003C5A
    CC003C4A94007C8AAC005C5654006486D40094928C0074B2F400A4AEB400ACB2
    5C0024329C003446AC002C426C00443E2400446ACC003C52B400BCF2FC005C6E
    5C006492FC004C4E34003C5AC400DCDE84005C7ABC003C4EAC00547AE4003C3A
    2400A4AABC004C4A2C003C361C00848E9C003C5ECC003452A400243EA4004442
    2C00344EB4003C6AB400949A940084AEF400A4B2B4002C221C009CA24C00545A
    34002C42AC004C4E4C006C96D4004456AC005C625C007C9EDC0034321C008486
    84003C4E8400DCE274007482A4005C5A4400344AAC00547ADC009CA6B4004C46
    2C00445EBC0074829C003C529C006C827C00547AF4003C56BC004C4A3C00F4F6
    9400342E1C003C62BC005C563C00343624008C8A8C003C4E9400545A54008C92
    9400FCFEFC006CB2FC004C6AD4002C42A40024369C0044422400ACAEB400544E
    3400445AC400443A240044361C00445ECC004C422C003C4EB4004875E40012EF
    AC00D7D53000D3243800FFFFFF00D5CD9400D35CC90000000000355370003704
    0E000004010000010000B45B7C000000000000000000000100003E33F40012EF
    6000D35CE800FF04410037040E000004010000010000B45B7C00000001001703
    A00012EF8000F833670000000C001705F800140000001703A0000000010012F0
    5400F58B7B00140000001703A00012F02000F58EC100ED60E000AC0010001703
    A800F833670000000C001705F800140000001703A0000000010012F09000F58B
    7B00140000001703A00012F05C00F58EC100ED60E000AC001000F8A82500F8A8
    430016889800AC001000ED60E000168DC000ED60E00000008000168890000100
    10001400000012EFE4001688980014000000F59685000000000014000000F596
    8500F596A50014060800AC001000000001000000010012F07400E71B8E00E71B
    96001688C00012F0C0000000010016889800AC0010000000000012F0440012F2
    940012F29400E9BB8600E8182000FFFFFF001688980014000000F5968500F596
    A50014060800AC001000000000000000000012F0D000E716E800E716EF00B449
    90004C3AE800000001000000000016889800AC00100012F0A00000000000287B
    701A1A521060016A2F4C786A140E88102E0C48627070862C40135F0462374A70
    351F47748B1C8A5E5E867F371B0F101077211D33584431367F80873A12066C70
    441A792020157F3D3F3A73575754178D27366715655B256B3985421164965844
    79363B5B3F3A435A0D718E098E96207C30371B163902051963642D116E963B37
    6F727E7A22242D61052A46590A965168120218823C6D762D2D4B2283756E0B72
    262D8E380A592D591E3E6603329607642D762D4624762D762B5C6E969696962A
    34462D4B2D46594B6E6E9696969696965996962A592209599696969696969696
    96969696244F499696969696969696969696969659594D969696969696960000
    0000000000000000000000000000000000000001000000010000000100000001
    0000000000000001000000070000800F0000D83F0000FC7F0000FC7F0000}
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 426
    Top = 338
    Width = 97
    Height = 25
    Caption = 'Close'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button6: TButton
    Left = 3
    Top = 337
    Width = 97
    Height = 25
    Caption = 'Help'
    TabOrder = 1
    Visible = False
  end
  object PageControl1: TPageControl
    Left = 2
    Top = 3
    Width = 521
    Height = 329
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'General'
      object Label1: TLabel
        Left = 16
        Top = 212
        Width = 79
        Height = 13
        Caption = 'Menu colour set:'
      end
      object GroupBox3: TGroupBox
        Left = 272
        Top = 8
        Width = 225
        Height = 121
        Caption = 'Associations:'
        TabOrder = 0
        object Image1: TImage
          Left = 8
          Top = 16
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D617036050000424D360500000000000036040000280000001000
            0000100000000100080000000000000100000000000000000000000100000000
            00003C3E6400B4AA940074726400647AA4004C569C00848A74007C8EA400D4D2
            CC006C6E54006C8EBC00345E7400BCBAB40094AAB4004C728C00748A8C00446A
            74008C9AA4009CA6B4007C9AC4007C8284006C869C005466AC00F4F6F4003C62
            6C00345E8400A4968C00949684007C8EAC006C869400ACB2C40034668C008C96
            C4004C7A9400546264007C7E6C00848A84007C96BC0084929400A4AEB400FCFE
            FC004C6E9C005C6A6400A4A2A4009C927C007C92BC004C6674007CA2C4006C7A
            8400848A9400446A8400949AAC006C86AC00F4FAFC008496AC00346E8C006476
            7C007C82B400848A7C006C92BC00C4CECC005C768C008C9ACC0034668400B4B2
            B400546A6C00B4A6A40094AAC40044567C00747A6400547AAC0094969C00DCD6
            DC003C5E7C0054768C00848A8C00546E7400A49E9C007C9EC4008C868C00648A
            A400F4FAF400A49E94007C92B4003C668C009CAEBC00ACA6A400948E7C00544A
            640064726C008492A400D4D6D400646E5C00748EBC003C5E7400C4C2C4005472
            8C007C8A8C00949AA400ACAAB4007C868400748A9C005C66BC003C5E84009C9A
            8C00AC9A84007C92AC00ACB2CC002C6A8C00547A940054666C007C827C00646E
            6400ACA2A4004C667C0084A2C4007C8E94004C6A8400949EB400748AB400FCFA
            FC007C96B400346E94008C8E7C007492BC00CCCED4003C6684005C6A6C0094AA
            CC00647AAC005C6E7C00A4B2BC00849EC400FCFAF40000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000272727272727272727272727272727272727272727272727080827272727
            27272727272727274141565B0808272727272727272741551B24192D0A6D0808
            272727274162063A4D122B3728187121080841413376353A2E722B2F3D037443
            485B5114092C35784D7F686D4503745D1E2955595C76691242106E0217185F66
            3158703283247825131C54070122813E365841697B2A304A543F57656A625144
            0F584C46600D4F7C474A0004151F5A0B2308411A2D66792061705E38825A7514
            3008270808054B3C0D6C0C3B26736008082727272708087A6D531E4960080827
            2727272727272708080563080827272727272727272727272708082727272727
            2727}
          Transparent = True
        end
        object Image2: TImage
          Left = 8
          Top = 36
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D617016030000424D160300000000000016020000280000001000
            0000100000000100080000000000000100000000000000000000780000007800
            000044528400A4AE9C007C867C005C86A4002C629400D4DEDC00949EAC003C6A
            B4009CAEC4004C729C008C96A400BCC6CC00849EBC006C6A64006C86B400546A
            7C00A49E8C00446A94004C72A400F4F6F400CCD6D400A4AEB4009C9EAC00647A
            AC00ACBED400647294008CA6C4006C7A7400648694007C86AC002C6AA400ACC6
            DC00546A74006C8EBC00B4B6B4004C7ABC00ECEEEC00A4B6D4008496B400849E
            C4006C7A94008C969400748EA4003C6A9400E4E6E400849EB400C4CECC007472
            5C006486BC00FCFEF4009CAEBC00A4A6AC00345A8C007486A4002C629C00D4DE
            E400A4B6CC005C7A9400949EBC005C7A8C00A4A68C004C6AA400547AB400ACBE
            DC009CA6C4007C8E9C008C8EA4003C6AA400BCCEE4006C726C005C7ABC007C96
            BC00647A9C00949EB4006C726400F4FEFC00ACAEBC009CA6B4003C5A7C00B4B6
            AC008C968400DCDEDC004C72BC00A4AECC005C729C008496AC00C4C6CC008C9E
            BC007486B40064727C009C9E9400546A94006C7AA400D4D6D4006C72940094A6
            C4007C869400346AA400B4C6DC00748EBC00B4B6BC00547ABC00ACB6D4008C9E
            C4008C969C008C9EB400CCCECC006C86BC00A4AEBC007486AC003C629C00647A
            B400B4BEDC007C8EAC00647274008496BC006C7A9C0074726400FCFEFC00A4A6
            B40076767676062A491D557676767676767676767669253F3853675842767676
            76767676676244443F38082752557676767676766744626218531A47650A4A75
            7676767647703F535F63632107680F1B2F4A5A5A2170255F5767634730191100
            4E2F10695F46124C540E0C1A736B5C340420716615285B5D685C1A25665F216D
            3645266D33135677335E5F25623F4065365958303D372C29686025626262253E
            04720117236C246A6058663F6225464C454A4F50166B56644D2763636F351E61
            482F760D2F516C225D561D3703091C4A2F767676762F6A022C13432B392F0D76
            76767676767637246A24394A2F4B76767676767676765D7676134A7676767676
            7676}
          Transparent = True
        end
        object Image3: TImage
          Left = 8
          Top = 56
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D617036030000424D360300000000000036000000280000001000
            0000100000000100180000000000000300000000000000000000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00102939526BFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFF08214229426339526B73735AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF08213921395A39526B7B8473
            73735A6B7363FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C9C
            94A5A59408214221396339526B4A637B395A8C737B6B6B7363737363FFFFFFFF
            FFFFFFFFFFFFFFFFA5A58C9C9C94849CAD6394BD10214221426339526B4A6B84
            296394215A8C526B7B6B7B7373735A6B73639C9C94A59C8C6B8CBD738CB57B94
            B57394BD10294221396339526B52637329639C39638C426B94425284395A7B73
            735AA5A58C6B84A56B94BD7394C64252735A738C10294A21396339526B4A6384
            296394396B9C527384315A8C296394526B73A5ADA58494AD6B84BD29425A0829
            4A425A7B52638410295239526B6B7373316394396394426B9431638C39639C6B
            736BA5AD9C8CA5B5849CC639526B10294AB5BDC6DEE7E7ADB5BD39526B39526B
            737B6B5A6B7B52738C21639C29639C63737BADA5A58494AD738CC639526B1029
            4AADB5BDDEDEDEDEDEDEDEE7E74A5A7B39526B738494737B84636B6B29639463
            7373A5AD9C8C9CAD84949439526B103152ADB5BDD6DEDECED6D6DEE7DEADBDC6
            39526B39526B3973A552738C6B736B6B7363B5B5AD8C948452638439526B1831
            52ADBDC6E7E7E7CECED6DEE7E7BDC6CE21426308214239526B396BA5637B9C73
            735AFFFFFF6B736373735A314A6308214A4A637BBDC6C6DEE7DEDEDEDEADBDBD
            29426B21395A425A7B6B736373735AFFFFFFFFFFFFFFFFFFFFFFFF39526B4A5A
            7318315A294263848C9CDEE7DEC6CECE21426329426B18315A39526BFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF39526B39526B0021392142633952734A637B
            294A6B18395A314A73FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FF39526B21314221395A314A6B294A6339526B314A63FFFFFFFFFFFFFFFFFFFF
            FFFF}
          Transparent = True
        end
        object Image4: TImage
          Left = 8
          Top = 76
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D617036030000424D360300000000000036000000280000001000
            0000100000000100180000000000000300000000000000000000000000000000
            0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF082139082139FFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF394A
            5A10315221396339526B736B6373735AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFF52637300213929426308294A63738C7B8473
            73735A6B7363FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5263
            7308213921395210315263738C4A637B395A8C737B6B6B7363737363FFFFFFFF
            FFFFFFFFFFFFFFFFA5A58C9C9C94849CAD73849C0018391831523952734A6B84
            296394215A8C526B7B6B7B7373735A6B73639C9C94A59C8C6B8CBD738CB57B94
            B57394BD63738408214218395A6B849429639C39638C426B94425284395A7B73
            735AA5A58CBDD6B5BDD6B57394C6849CAD6394BD6373841029421029526B8494
            296394396B9C527384315A8C296394526B73A5ADA59CBD9C9CC694BDD6B5B5D6
            ADB5D6AD8CA5CE73848C0021425A738C316394396394426B9431638C39639C6B
            736BA5AD9CADC6AD8CAD94B5D6B5ADCEA5ADD6A5949C9473848C08294229426B
            737B6B5A6B7B52738C21639C29639C63737BADA5A5CEE7CE739C8CA5CEADB5D6
            B5A5CEA5D6EFCE73848C10294A29426B73849C738494737B84636B6BDEEFD69C
            BDADA5AD9C8C9CADB5C6C684A594B5D6BDB5D6BDBDDEBD738C84103152314A7B
            73849CD6E7CEC6DEBDCEEFC69CC6A59CBDADB5B5AD8C9484526384C6D6D68CA5
            A5ADCEBDC6E7CE6B8C7B18315A4A638C5273739CC69CB5D6B594B5AD9CBDAD73
            735AFFFFFF6B736373735A63737BBDC6C67B9C94BDDEC66B94732952635A8484
            94C6A5B5CEC68CADAD94B5A5BDD6B5FFFFFFFFFFFFFFFFFFFFFFFF73735A6B6B
            63BDCEC68CADA584A58C52736B94AD9C9CBDAD84A59C94B5A5BDDEBDFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFB5C6B5B5C6B5B5C6B59CBDADBDD6B58CAD94
            A5BDADADCEADDEEFDEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB5C6B594B59C8CAD
            9C94AD9CB5CEBDB5C6B56B7363A5BDAD94AD9C9CBDADB5CEB5B5C6B5FFFFFFFF
            FFFF}
          Transparent = True
        end
        object Image5: TImage
          Left = 8
          Top = 96
          Width = 16
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D617036050000424D360500000000000036040000280000001000
            0000100000000100080000000000000100000000000000000000000100000000
            00003C4A84009C9E7C00243AB40074725C00546AAC006C86BC003C429400FCFE
            F400849EC40054728400648694004C6AD4005C86DC00345A8C008C9EAC006C6A
            64003C6A94003C5AAC00547AE4009CC6FC005C86E4004C627C0064727400749E
            E4003C72A40064869C0024629C009C9E8C005472D400A4AE9C003C62DC007CAE
            F4008496AC00848E84004C62C40054729400546274003452BC00648EE4007C86
            74003C629C00A4A68C00344AB400546ABC004C6ADC00748ED4008CA6B4002C6A
            A400547AEC004C6A84006C7A7400949E940084B6F400849694003C5A7C006C72
            6C006C8EBC003C4A9400F4FEFC00747A840034628C00646A6C00647AE4004C62
            840064727C006C9EEC00647A9C003462A4004C72DC00B4B6AC006C96BC008C96
            84003452C400648EEC005472C4006C8EDC0084B6FC0044528400ACA684002C42
            BC006C72640054728C007C868C00546AD400ACA6A400746A6400446A9400445A
            B4005C7AE400A4CEFC005C86EC006C7274007C9EE4004472A4006C86A4002C62
            9C00A49E8C00A4AEA4005C7A9400546A74004C62A400344AC400546AC400546A
            DC009CA6B4003C6AA4009C9E94008CB6F400748EC400344A9C00FCFEFC002C62
            9400546284005472DC007496BC009C968C003C52C4006C8EEC00748EDC000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            00006E6E6E6E6E6E6E6E6E6E6E2B026E6E6E6E6E6E6E6E6E6E6E55031C307567
            6E6E6E6E6E6E6E6E296A01274434135A6E6E6E6E6E6E124F71721B1571414C30
            6E6E6E6E29715A1F1E1C01314471443203506A60382C4C595A2C73241C2C564D
            3603295E6C0B5C4144714E3F4444090D6F636120054871671C6821161C44103C
            28371D2E082A440E336210234412091A2F1654202D6544526F1A43181C2C3B3D
            6F161D0E352544181918124B441C1851375045213F25712F4444110644442F18
            42036E500357441C3900640C44440A50036E6E6E6E48390004305A261C030F6E
            6E6E6E6E6E224A14304B4450036E6E6E6E6E6E6E6E44302C1C03506E6E6E6E6E
            6E6E}
          Transparent = True
        end
        object cbLpp: TCheckBox
          Left = 32
          Top = 16
          Width = 185
          Height = 17
          Caption = '*.lpp (LBA Package Editor projects)'
          TabOrder = 0
        end
        object cbHqr: TCheckBox
          Left = 32
          Top = 36
          Width = 185
          Height = 17
          Caption = '*.hqr (resource packages)'
          TabOrder = 1
        end
        object cbIle: TCheckBox
          Left = 32
          Top = 56
          Width = 185
          Height = 17
          Caption = '*.ile (island packages)'
          TabOrder = 2
        end
        object cbObl: TCheckBox
          Left = 32
          Top = 76
          Width = 185
          Height = 17
          Caption = '*.obl (island object packages)'
          TabOrder = 3
        end
        object cbVox: TCheckBox
          Left = 32
          Top = 96
          Width = 169
          Height = 17
          Caption = '*.vox (speech packages)'
          TabOrder = 4
        end
      end
      object cbOpenLast: TCheckBox
        Left = 24
        Top = 16
        Width = 145
        Height = 17
        Caption = 'Open last project at startup'
        TabOrder = 1
      end
      object cbRemSize: TCheckBox
        Left = 24
        Top = 40
        Width = 209
        Height = 17
        Caption = 'Remember size of the main window'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object cbRemPos: TCheckBox
        Left = 24
        Top = 56
        Width = 209
        Height = 17
        Caption = 'Remember position of the main window'
        TabOrder = 3
      end
      object cbIgnoreLast: TCheckBox
        Left = 24
        Top = 80
        Width = 161
        Height = 17
        Hint = 'Sometimes files with incorrect last offset are generally correct'
        Caption = 'Ignore erroneous last offset'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object cbDelTemp: TCheckBox
        Left = 24
        Top = 104
        Width = 153
        Height = 17
        Caption = 'Delete temp files on close'
        TabOrder = 5
      end
      object cbSameFile: TCheckBox
        Left = 24
        Top = 128
        Width = 217
        Height = 17
        Hint = 
          'The output file will be automatically set the same as input file' +
          ', but you can still change it.'
        Caption = 'Same file for input and output for default'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
      end
      object cbIncInfo: TCheckBox
        Left = 24
        Top = 152
        Width = 457
        Height = 17
        Caption = 
          'Include entry info in extracted file name if possible (if info c' +
          'olumn isn'#39't empty)'
        TabOrder = 7
        OnClick = cbIncInfoClick
      end
      object cbNoIncPack: TCheckBox
        Left = 40
        Top = 168
        Width = 265
        Height = 17
        Caption = 'Don'#39't include package name in extracted file name'
        Enabled = False
        TabOrder = 8
      end
      object cbColourSet: TComboBox
        Left = 104
        Top = 208
        Width = 73
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 9
        OnChange = cbColourSetChange
        Items.Strings = (
          'Blue'
          'Green'
          'Red'
          'Yellow'
          'Purple'
          'Orange')
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Mouse events'
      ImageIndex = 2
      object rgLMBMode: TRadioGroup
        Left = 16
        Top = 32
        Width = 233
        Height = 97
        Caption = 'Dragging entries with LEFT mouse button:'
        ItemIndex = 0
        Items.Strings = (
          'Never drag anything'
          'Always drag replacement'
          'Alaways drag entry'
          'Drag replacement, if none then drag entry'
          'Depending on mouse position')
        TabOrder = 0
      end
      object rgRMBMode: TRadioGroup
        Left = 264
        Top = 32
        Width = 233
        Height = 97
        Caption = 'Dragging entries with RIGHT mouse button:'
        ItemIndex = 0
        Items.Strings = (
          'Never drag anything'
          'Always drag replacement'
          'Alaways drag entry'
          'Drag replacement, if none then drag entry'
          'Depending on mouse position')
        TabOrder = 1
      end
      object rgDblMode: TRadioGroup
        Left = 56
        Top = 160
        Width = 177
        Height = 89
        Caption = 'When an entry is double-clicked:'
        ItemIndex = 0
        Items.Strings = (
          'Do nothing'
          'Extract'
          'Replace'
          'Open with associated edior')
        TabOrder = 2
        OnClick = rgDblModeClick
      end
      object rgNoEditMode: TRadioGroup
        Left = 240
        Top = 160
        Width = 217
        Height = 89
        Caption = 'If no editor associated:'
        ItemIndex = 0
        Items.Strings = (
          'Do nothing'
          'Extract'
          'Replace'
          'Open with universal editor (if specified)')
        TabOrder = 3
        Visible = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Directories'
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 64
        Top = 8
        Width = 385
        Height = 65
        Caption = 'Default opening and saving directory:'
        TabOrder = 0
        object rbOsDir0: TRadioButton
          Tag = 1
          Left = 8
          Top = 16
          Width = 73
          Height = 17
          Caption = 'Last used'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = rbOsDir2Click
        end
        object rbOsDir1: TRadioButton
          Tag = 1
          Left = 128
          Top = 16
          Width = 121
          Height = 17
          Caption = 'Where the program is'
          TabOrder = 1
          OnClick = rbOsDir2Click
        end
        object rbOsDir2: TRadioButton
          Tag = 1
          Left = 280
          Top = 16
          Width = 65
          Height = 17
          Caption = 'Custom:'
          TabOrder = 2
          OnClick = rbOsDir2Click
        end
        object eOsDir: TEdit
          Left = 8
          Top = 36
          Width = 352
          Height = 21
          Ctl3D = True
          Enabled = False
          ParentCtl3D = False
          TabOrder = 3
        end
        object StaticText1: TStaticText
          Left = 358
          Top = 36
          Width = 19
          Height = 21
          AutoSize = False
          BevelEdges = [beTop, beRight, beBottom]
          BevelInner = bvLowered
          BevelKind = bkTile
          TabOrder = 5
        end
        object bOsDir: TButton
          Tag = 1
          Left = 358
          Top = 38
          Width = 17
          Height = 17
          Caption = '...'
          Enabled = False
          TabOrder = 4
          OnClick = bOsDirClick
        end
      end
      object GroupBox4: TGroupBox
        Left = 64
        Top = 80
        Width = 385
        Height = 65
        Caption = 'Default input and output directory for packages:'
        TabOrder = 1
        object eIoDir: TEdit
          Left = 8
          Top = 36
          Width = 352
          Height = 21
          Ctl3D = True
          Enabled = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object StaticText2: TStaticText
          Left = 358
          Top = 36
          Width = 19
          Height = 21
          AutoSize = False
          BevelEdges = [beTop, beRight, beBottom]
          BevelInner = bvLowered
          BevelKind = bkTile
          TabOrder = 5
        end
        object rbIoDir0: TRadioButton
          Tag = 2
          Left = 8
          Top = 16
          Width = 73
          Height = 17
          Caption = 'Last used'
          Checked = True
          TabOrder = 3
          TabStop = True
          OnClick = rbOsDir2Click
        end
        object rbIoDir1: TRadioButton
          Tag = 2
          Left = 128
          Top = 16
          Width = 121
          Height = 17
          Caption = 'Where the program is'
          TabOrder = 2
          OnClick = rbOsDir2Click
        end
        object bIoDir: TButton
          Tag = 2
          Left = 358
          Top = 38
          Width = 17
          Height = 17
          Caption = '...'
          Enabled = False
          TabOrder = 4
          OnClick = bOsDirClick
        end
        object rbIoDir2: TRadioButton
          Tag = 2
          Left = 280
          Top = 16
          Width = 65
          Height = 17
          Caption = 'Custom:'
          TabOrder = 1
          OnClick = rbOsDir2Click
        end
      end
      object GroupBox2: TGroupBox
        Left = 64
        Top = 152
        Width = 385
        Height = 65
        Caption = 'Default replace and extract directory:'
        TabOrder = 2
        object eReDir: TEdit
          Left = 8
          Top = 36
          Width = 352
          Height = 21
          Ctl3D = True
          Enabled = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object StaticText3: TStaticText
          Left = 358
          Top = 36
          Width = 19
          Height = 21
          AutoSize = False
          BevelEdges = [beTop, beRight, beBottom]
          BevelInner = bvLowered
          BevelKind = bkTile
          TabOrder = 5
        end
        object rbReDir0: TRadioButton
          Tag = 3
          Left = 8
          Top = 16
          Width = 73
          Height = 17
          Caption = 'Last used'
          Checked = True
          TabOrder = 3
          TabStop = True
          OnClick = rbOsDir2Click
        end
        object rbReDir1: TRadioButton
          Tag = 3
          Left = 128
          Top = 16
          Width = 129
          Height = 17
          Caption = 'Where the program is'
          TabOrder = 2
          OnClick = rbOsDir2Click
        end
        object bReDir: TButton
          Tag = 3
          Left = 358
          Top = 38
          Width = 17
          Height = 17
          Caption = '...'
          Enabled = False
          TabOrder = 4
          OnClick = bOsDirClick
        end
        object rbReDir2: TRadioButton
          Tag = 3
          Left = 280
          Top = 16
          Width = 65
          Height = 17
          Caption = 'Custom:'
          TabOrder = 1
          OnClick = rbOsDir2Click
        end
      end
      object GroupBox5: TGroupBox
        Left = 64
        Top = 224
        Width = 385
        Height = 65
        Caption = 'Directory for temporary files:'
        TabOrder = 3
        object eTmDir: TEdit
          Left = 8
          Top = 36
          Width = 352
          Height = 21
          Ctl3D = True
          Enabled = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object StaticText4: TStaticText
          Left = 358
          Top = 36
          Width = 19
          Height = 21
          AutoSize = False
          BevelEdges = [beTop, beRight, beBottom]
          BevelInner = bvLowered
          BevelKind = bkTile
          TabOrder = 5
        end
        object rbTmDir0: TRadioButton
          Tag = 3
          Left = 8
          Top = 16
          Width = 97
          Height = 17
          Caption = 'Windows TEMP'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = rbOsDir2Click
        end
        object bTmDir: TButton
          Tag = 3
          Left = 358
          Top = 38
          Width = 17
          Height = 17
          Caption = '...'
          Enabled = False
          TabOrder = 3
          OnClick = bOsDirClick
        end
        object rbTmDir2: TRadioButton
          Tag = 3
          Left = 280
          Top = 16
          Width = 65
          Height = 17
          Caption = 'Custom:'
          TabOrder = 1
          OnClick = rbOsDir2Click
        end
        object rbTmDir1: TRadioButton
          Tag = 3
          Left = 128
          Top = 16
          Width = 129
          Height = 17
          Caption = 'Where the program is'
          TabOrder = 4
          OnClick = rbOsDir2Click
        end
      end
    end
  end
end
