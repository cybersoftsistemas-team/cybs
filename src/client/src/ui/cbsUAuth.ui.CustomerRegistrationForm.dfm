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
  object pnlStep03: TUniContainerPanel [0]
    Left = 11
    Top = 8
    Width = 429
    Height = 287
    Hint = ''
    ParentColor = False
    TabOrder = 2
  end
  object pnlStep01: TUniContainerPanel [1]
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
  object pnlStep02: TUniContainerPanel [2]
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
    object pnlNatural: TUniContainerPanel
      Left = 107
      Top = 49
      Width = 322
      Height = 238
      Hint = ''
      ParentColor = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 5
      object cbxNatCity: TUniDBLookupComboBox
        Left = 209
        Top = 154
        Width = 85
        Hint = ''
        ListField = 'Name'
        ListSource = damCustomerRegistration.dsoCYT
        KeyField = 'Id'
        ListFieldIndex = 0
        DataField = 'PlaceOfBirthId'
        DataSource = damCustomerRegistration.dsoNAT
        TabOrder = 11
        Color = clWindow
        MatchFieldWidth = False
        RemoteQuery = True
        FieldLabel = 'Cidade'
        FieldLabelAlign = laTop
        Triggers = <
          item
            ButtonId = 0
          end
          item
            ImageIndex = 0
            ButtonId = 1
            Visible = False
            HandleClicks = True
          end>
        Images = nilstMain
      end
      object cbxNatState: TUniDBLookupComboBox
        Left = 93
        Top = 154
        Width = 110
        Hint = ''
        ListField = 'Name'
        ListSource = damCustomerRegistration.dsoSTA
        KeyField = 'Id'
        ListFieldIndex = 0
        TabOrder = 10
        Color = clWindow
        MatchFieldWidth = False
        RemoteQuery = True
        FieldLabel = 'Estado'
        FieldLabelAlign = laTop
        OnSelect = cbxNatStateSelect
      end
      object cbxNatCountry: TUniDBLookupComboBox
        Left = 4
        Top = 154
        Width = 82
        Hint = ''
        ListOnlyMode = lmFollowSource
        ListField = 'Name'
        ListSource = damCustomerRegistration.dsoCOU
        KeyField = 'Id'
        ListFieldIndex = 0
        TabOrder = 9
        Color = clWindow
        MatchFieldWidth = False
        RemoteQuery = True
        FieldLabel = 'Pa'#237's'
        FieldLabelAlign = laTop
      end
      object cbxNatNationality: TUniDBLookupComboBox
        Left = 93
        Top = 89
        Width = 110
        Hint = ''
        ListField = 'Name'
        ListSource = damCustomerRegistration.dsoNTU
        KeyField = 'Id'
        ListFieldIndex = 0
        DataField = 'NationalityId'
        DataSource = damCustomerRegistration.dsoNAT
        TabOrder = 7
        Color = clWindow
        RemoteQuery = True
        FieldLabel = 'Nacionalidade'
        FieldLabelAlign = laTop
      end
      object cbxNatGender: TUniDBLookupComboBox
        Left = 4
        Top = 89
        Width = 82
        Hint = ''
        ListField = 'Name'
        ListSource = damCustomerRegistration.dsoGEN
        KeyField = 'Id'
        ListFieldIndex = 0
        DataField = 'GenderId'
        DataSource = damCustomerRegistration.dsoNAT
        TabOrder = 6
        Color = clWindow
        FieldLabel = 'Sexo'
        FieldLabelAlign = laTop
      end
      object edtNatFirstName: TUniDBEdit
        Left = 4
        Top = 1
        Width = 155
        Height = 22
        Hint = ''
        DataField = 'FirstName'
        DataSource = damCustomerRegistration.dsoNAT
        TabOrder = 1
        FieldLabel = 'Primeiro Nome'
        FieldLabelAlign = laTop
      end
      object edtNatLastName: TUniDBEdit
        Left = 165
        Top = 1
        Width = 155
        Height = 22
        Hint = ''
        DataField = 'LastName'
        DataSource = damCustomerRegistration.dsoNAT
        TabOrder = 2
        FieldLabel = 'Sobrenome'
        FieldLabelAlign = laTop
      end
      object edtNatBirthday: TUniDBDateTimePicker
        Left = 4
        Top = 45
        Width = 82
        Hint = ''
        DataField = 'Birthday'
        DataSource = damCustomerRegistration.dsoNAT
        DateTime = 46012.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 3
        FieldLabel = 'Nascimento'
        FieldLabelAlign = laTop
      end
      object edtNatSSN: TUniDBEdit
        Left = 93
        Top = 45
        Width = 110
        Height = 22
        Hint = ''
        DataField = 'SSN'
        DataSource = damCustomerRegistration.dsoNAT
        TabOrder = 4
        InputMask.Mask = '999.999.999-99'
        InputMask.RemoveWhiteSpace = True
        FieldLabel = 'CPF'
        FieldLabelAlign = laTop
      end
      object edtNatIDCard: TUniDBEdit
        Left = 210
        Top = 45
        Width = 110
        Height = 22
        Hint = ''
        DataField = 'IDCard'
        DataSource = damCustomerRegistration.dsoNAT
        TabOrder = 5
        FieldLabel = 'RG'
        FieldLabelAlign = laTop
      end
      object labPlaceOfBirthId: TUniLabel
        Left = 4
        Top = 140
        Width = 68
        Height = 13
        Hint = ''
        Caption = 'Naturalidade'
        ParentFont = False
        Font.Style = [fsBold]
        TabOrder = 8
      end
      object btnNewCity: TUniSpeedButton
        Left = 297
        Top = 177
        Width = 23
        Height = 22
        Action = actNewCity
        ParentColor = False
        ImageIndex = 0
        TabOrder = 12
      end
    end
    object pnlLegal: TUniContainerPanel
      Left = 107
      Top = 49
      Width = 322
      Height = 238
      Hint = ''
      Visible = False
      ParentColor = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 4
      object cbxLegStateId: TUniDBLookupComboBox
        Left = 124
        Top = 89
        Width = 111
        Hint = ''
        ListField = 'Name'
        ListSource = damCustomerRegistration.dsoSTE
        KeyField = 'Id'
        ListFieldIndex = 0
        DataField = 'StateId'
        DataSource = damCustomerRegistration.dsoLEG
        TabOrder = 9
        Color = clWindow
        FieldLabel = 'Estado'
        FieldLabelAlign = laTop
      end
      object cbxLegNationalityId: TUniDBLookupComboBox
        Left = 4
        Top = 89
        Width = 112
        Hint = ''
        ListField = 'Name'
        ListSource = damCustomerRegistration.dsoNTY
        KeyField = 'Id'
        ListFieldIndex = 0
        DataField = 'NationalityId'
        DataSource = damCustomerRegistration.dsoLEG
        TabOrder = 8
        Color = clWindow
        FieldLabel = 'Nacionalidade'
        FieldLabelAlign = laTop
      end
      object edtLegName: TUniDBEdit
        Left = 4
        Top = 1
        Width = 155
        Height = 22
        Hint = ''
        DataField = 'Name'
        DataSource = damCustomerRegistration.dsoLEG
        TabOrder = 1
        FieldLabel = 'Nome'
        FieldLabelAlign = laTop
      end
      object edtLegDoingBusinessAs: TUniDBEdit
        Left = 166
        Top = 1
        Width = 155
        Height = 22
        Hint = ''
        DataField = 'DoingBusinessAs'
        DataSource = damCustomerRegistration.dsoLEG
        TabOrder = 2
        FieldLabel = 'Nome fantasia'
        FieldLabelAlign = laTop
      end
      object edtLegFoundationDate: TUniDBDateTimePicker
        Left = 4
        Top = 45
        Width = 79
        Hint = ''
        DataField = 'FoundationDate'
        DataSource = damCustomerRegistration.dsoLEG
        DateTime = 46014.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        TimeFormat = 'HH:mm:ss'
        TabOrder = 3
        FieldLabel = 'Fundada em'
        FieldLabelAlign = laTop
      end
      object edtLegCRN: TUniDBEdit
        Left = 90
        Top = 45
        Width = 112
        Height = 22
        Hint = ''
        DataField = 'CRN'
        DataSource = damCustomerRegistration.dsoLEG
        TabOrder = 4
        InputMask.Mask = '99.999.999/9999-99'
        InputMask.RemoveWhiteSpace = True
        FieldLabel = 'CNPJ'
        FieldLabelAlign = laTop
      end
      object cbxLegCompanyTypeId: TUniDBLookupComboBox
        Left = 209
        Top = 45
        Width = 112
        Hint = ''
        ListField = 'Name'
        ListSource = damCustomerRegistration.dsoCTP
        KeyField = 'Id'
        ListFieldIndex = 0
        DataField = 'CompanyTypeId'
        DataSource = damCustomerRegistration.dsoLEG
        TabOrder = 5
        Color = clWindow
        FieldLabel = 'Tipo'
        FieldLabelAlign = laTop
      end
      object edtLegStateInscriptionNumber: TUniDBEdit
        Left = 4
        Top = 134
        Width = 154
        Height = 22
        Hint = ''
        DataField = 'StateInscriptionNumber'
        DataSource = damCustomerRegistration.dsoLEG
        TabOrder = 6
        FieldLabel = 'Inscri'#231#227'o Estadual'
        FieldLabelAlign = laTop
      end
      object edtLegMunicipalInscription: TUniDBEdit
        Left = 166
        Top = 134
        Width = 154
        Height = 22
        Hint = ''
        DataField = 'MunicipalInscription'
        DataSource = damCustomerRegistration.dsoLEG
        TabOrder = 7
        FieldLabel = 'Inscri'#231#227'o Municipal'
        FieldLabelAlign = laTop
      end
    end
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
      TabOrder = 7
      Group = 1
      OnClick = rbtNaturalClick
    end
    object rbtLegal: TUniRadioButton
      Left = 0
      Top = 79
      Width = 101
      Height = 18
      Hint = ''
      Caption = 'Pessoa Jur'#237'dica'
      TabOrder = 8
      Group = 1
      OnClick = rbtLegalClick
    end
    object pnlBreakLeft: TUniPanel
      Left = 101
      Top = 55
      Width = 1
      Height = 234
      Hint = ''
      Enabled = False
      BodyRTL = False
      TabOrder = 6
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
      TabOrder = 1
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
  end
  object pnlButtons: TUniSimplePanel [3]
    Left = 11
    Top = 312
    Width = 429
    Height = 25
    Hint = ''
    ParentColor = False
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 4
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
  object pnlBreak: TUniPanel [4]
    Left = 11
    Top = 301
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
    object actNewCity: TAction
      Enabled = False
      ImageIndex = 0
      OnExecute = actNewCityExecute
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
      01000000FFFFFF1F04EC00000089504E470D0A1A0A0000000D49484452000000
      100000001008060000001FF3FF610000001974455874536F6674776172650041
      646F626520496D616765526561647971C9653C0000003D744558745469746C65
      004E65773B506167653B426172733B526962626F6E3B5374616E646172643B49
      74656D3B426C616E6B3B44656661756C743B456D7074793B130452ED00000045
      49444154785EEDCCB10900200C44517772C5D4D9D0452C3C09A820C221499B83
      CF75AF00087500110169ACAF14603340559B215EC0AE6FC4035C7180C7810412
      F8EC01424D9E9C52B21F391F500000000049454E44AE426082}
  end
end
