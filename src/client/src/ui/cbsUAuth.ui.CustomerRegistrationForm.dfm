inherited frmCustomerRegistration: TfrmCustomerRegistration
  ClientHeight = 347
  ClientWidth = 451
  Caption = 'Registrar Cliente'
  BorderStyle = bsNone
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'  if ' +
      '(AppEnv.isElectron()) {'#13#10'      sender.addCls("electron-reg-custo' +
      'mer-pos");'#13#10'   }'#13#10'}')
  ExplicitWidth = 451
  ExplicitHeight = 347
  TextHeight = 15
  object pnlStep01: TUniContainerPanel [0]
    Left = 11
    Top = 8
    Width = 429
    Height = 287
    Hint = ''
    ParentColor = False
    TabOrder = 1
    object labTitle: TUniLabel
      Left = 3
      Top = 8
      Width = 255
      Height = 21
      Hint = ''
      Caption = 'Bem-vindo ao Registro de Cliente'
      ParentFont = False
      Font.Height = -16
      Font.Style = [fsBold]
      TabOrder = 1
    end
    object labInfo: TUniLabel
      Left = 22
      Top = 112
      Width = 400
      Height = 42
      Hint = ''
      AutoSize = False
      Caption = 
        'Este assistente ir'#225' gui'#225'-lo passo a passo no processo de registr' +
        'o de um novo cliente no sistema. Voc'#234' s'#243' precisa seguir as etapa' +
        's, preencher as informa'#231#245'es'#13#10'solicitadas e avan'#231'ar quando estive' +
        'r pronto.'
      TabOrder = 2
    end
  end
  object pnlStep02: TUniContainerPanel [1]
    Left = 11
    Top = 8
    Width = 429
    Height = 287
    Hint = ''
    ParentColor = False
    TabOrder = 0
    DesignSize = (
      429
      287)
    object pnlBreakTop: TUniPanel
      Left = 0
      Top = 49
      Width = 429
      Height = 1
      Hint = ''
      Enabled = False
      BodyRTL = False
      Anchors = [akLeft, akRight, akBottom]
      TabOrder = 3
      ShowCaption = False
      Caption = 'pnlBreak'
    end
    object rbtNatural: TUniRadioButton
      Left = 0
      Top = 56
      Width = 101
      Height = 18
      Hint = ''
      Checked = True
      Caption = 'Pessoa F'#237'sica'
      TabOrder = 6
      Group = 1
    end
    object rbtLegal: TUniRadioButton
      Left = 0
      Top = 79
      Width = 101
      Height = 18
      Hint = ''
      Caption = 'Pessoa Jur'#237'dica'
      TabOrder = 7
      Group = 1
    end
    object pnlBreakLeft: TUniPanel
      Left = 101
      Top = 55
      Width = 1
      Height = 234
      Hint = ''
      Enabled = False
      BodyRTL = False
      TabOrder = 5
      ShowCaption = False
      Caption = 'pnlBreak'
    end
    object labStep02Title: TUniLabel
      Left = 0
      Top = 0
      Width = 89
      Height = 13
      Hint = ''
      Caption = 'Dados do Cliente'
      ParentFont = False
      Font.Style = [fsBold]
      TabOrder = 0
    end
    object labStep02SubTitle: TUniLabel
      Left = 0
      Top = 17
      Width = 442
      Height = 27
      Hint = ''
      AutoSize = False
      Caption = 
        'Marque o tipo de registro (Pessoa F'#237'sica ou Jur'#237'dica) e preencha' +
        ' os dados nos campos abaixo.'
      ParentFont = False
      TabOrder = 2
    end
    object UniContainerPanel1: TUniContainerPanel
      Left = 107
      Top = 49
      Width = 322
      Height = 238
      Hint = ''
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 4
      object edtFirstName: TUniDBEdit
        Left = 4
        Top = 1
        Width = 155
        Height = 22
        Hint = ''
        TabOrder = 1
        FieldLabel = 'Primeiro Nome'
        FieldLabelAlign = laTop
      end
      object edtLastName: TUniDBEdit
        Left = 166
        Top = 1
        Width = 155
        Height = 22
        Hint = ''
        TabOrder = 2
        FieldLabel = 'Sobrenome'
        FieldLabelAlign = laTop
      end
      object edtBirthday: TUniDBDateTimePicker
        Left = 4
        Top = 45
        Width = 79
        Hint = ''
        DateTime = 46012.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 3
        FieldLabel = 'Nascimento'
        FieldLabelAlign = laTop
      end
      object edtSSN: TUniDBEdit
        Left = 90
        Top = 45
        Width = 112
        Height = 22
        Hint = ''
        TabOrder = 4
        FieldLabel = 'CPF'
        FieldLabelAlign = laTop
      end
      object edtIDCard: TUniDBEdit
        Left = 209
        Top = 45
        Width = 112
        Height = 22
        Hint = ''
        TabOrder = 5
        FieldLabel = 'RG'
        FieldLabelAlign = laTop
      end
    end
  end
  object pnlButtons: TUniSimplePanel [2]
    Left = 11
    Top = 312
    Width = 429
    Height = 25
    Hint = ''
    ParentColor = False
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 3
    object btnCancel: TUniBitBtn
      AlignWithMargins = True
      Left = 347
      Top = 0
      Width = 82
      Height = 25
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = actCancel
      Cancel = True
      ModalResult = 2
      Align = alRight
      TabOrder = 4
      IconAlign = iaRight
    end
    object btnFinish: TUniBitBtn
      AlignWithMargins = True
      Left = 255
      Top = 0
      Width = 82
      Height = 25
      Margins.Left = 7
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = actFinish
      Align = alRight
      TabOrder = 3
      IconAlign = iaRight
    end
    object btnNext: TUniBitBtn
      AlignWithMargins = True
      Left = 166
      Top = 0
      Width = 82
      Height = 25
      Margins.Left = 7
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = actNext
      Align = alRight
      TabOrder = 2
      IconAlign = iaRight
    end
    object btnBack: TUniBitBtn
      AlignWithMargins = True
      Left = 77
      Top = 0
      Width = 82
      Height = 25
      Margins.Left = 7
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = actBack
      Align = alRight
      TabOrder = 1
    end
  end
  object pnlBreak: TUniPanel [3]
    Left = 11
    Top = 301
    Width = 429
    Height = 1
    Hint = ''
    Enabled = False
    BodyRTL = False
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    ShowCaption = False
    Caption = 'pnlBreak'
  end
  inherited aclMain: TUniActionList
    Left = 11
    Top = 310
    object actBack: TAction
      Caption = '< Voltar'
      OnExecute = actBackExecute
    end
    object actCancel: TAction
      Caption = 'Cancelar'
    end
    object actFinish: TAction
      Caption = 'Finalizar >>|'
    end
    object actNext: TAction
      Caption = 'Avan'#231'ar >'
      OnExecute = actNextExecute
    end
  end
  inherited ilaMain: TUniImageListAdapter
    Left = 39
    Top = 310
  end
  inherited nilstMain: TUniNativeImageList
    Left = 67
    Top = 310
    Images = {
      03000000FFFFFF1F04DD00000089504E470D0A1A0A0000000D49484452000000
      100000001008060000001FF3FF610000001974455874536F6674776172650041
      646F626520496D616765526561647971C9653C00000021744558745469746C65
      00507265763B4172726F773B4C6566743B4261636B3B526577696E640B2B870F
      0000005249444154785EBD93B10D002008045D90751CC0251CC115DC0EADBE32
      01AFA0F886E42E24F0CDDD53B1B1ED354FC3374E04828940301108FE16F43505
      1381602078C0B51BC4127E85AA3F8825055DE06DE439F4E8D3A82E8C6E840000
      000049454E44AE426082FFFFFF1F04D700000089504E470D0A1A0A0000000D49
      484452000000100000001008060000001FF3FF610000001974455874536F6674
      776172650041646F626520496D616765526561647971C9653C0000001C744558
      745469746C65004E6578743B506C61793B4172726F773B52696768743B52716C
      480000005149444154785EC5D3C109C0201005D13438ED58409A4809B660771B
      3CFD4308C81CF4F0F0362CAC7B55D507F760BE2BFE0295880F4CF840E003810F
      04AD3F3210F840706C028E6D81FD3FD1DF82BF46EF050E8BD3A832CB82150000
      000049454E44AE426082FFFFFF1F04E700000089504E470D0A1A0A0000000D49
      484452000000100000001008060000001FF3FF610000001974455874536F6674
      776172650041646F626520496D616765526561647971C9653C0000002A744558
      745469746C65004C6173743B4172726F773B466F72776172643B536B69703B4E
      6578743B526577696E643B5B4492450000005349444154785EC5D3B109002110
      44D16BF0B76301D7C495600B7637C724069B884CB0C1C740782CE83E9276BC0B
      9F37554005A9773A021B0901470A3852C031E617018E1450EB04B4BD020D3F31
      D885681BA37E6F30C8BB3E89258D0000000049454E44AE426082}
  end
end
