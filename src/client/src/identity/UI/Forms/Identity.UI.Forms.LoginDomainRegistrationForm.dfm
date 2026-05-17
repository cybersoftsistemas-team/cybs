inherited frmDomainRegistration: TfrmDomainRegistration
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
  object pnlStep02: TUniContainerPanel [0]
    Left = 11
    Top = 8
    Width = 429
    Height = 287
    Hint = ''
    ParentColor = False
    TabOrder = 1
    DesignSize = (
      429
      287)
    object pnlBreakTop: TUniPanel
      Left = 0
      Top = 42
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
    object labStep02Title: TUniLabel
      Left = 0
      Top = 0
      Width = 98
      Height = 13
      Hint = ''
      Caption = 'Dados do Dom'#237'nio'
      ParentFont = False
      Font.Style = [fsBold]
      TabOrder = 0
    end
    object labStep02SubTitle: TUniLabel
      Left = 16
      Top = 20
      Width = 287
      Height = 13
      Hint = ''
      Caption = 'Digite um nome para o novo dom'#237'nio no campo abaixo.'
      ParentFont = False
      TabOrder = 2
    end
    object edtDomainName: TUniEdit
      Left = 86
      Top = 152
      Width = 273
      Hint = ''
      Text = ''
      TabOrder = 5
      ClearButton = True
      FieldLabel = 'Nome do dom'#237'nio'
      FieldLabelWidth = 130
      FieldLabelAlign = laTop
      FieldLabelFont.Style = [fsBold]
    end
    object labInfo2: TUniLabel
      Left = 29
      Top = 72
      Width = 400
      Height = 42
      Hint = ''
      AutoSize = False
      Caption = 
        'O dom'#237'nio identifica a empresa ou organiza'#231#227'o utilizada no acess' +
        'o ao sistema, separando usu'#225'rios, permiss'#245'es e informa'#231#245'es de ca' +
        'da ambiente.'
      TabOrder = 4
    end
  end
  object pnlStep01: TUniContainerPanel [1]
    Left = 11
    Top = 8
    Width = 429
    Height = 287
    Hint = ''
    ParentColor = False
    TabOrder = 0
    object labInfo: TUniLabel
      Left = 21
      Top = 93
      Width = 387
      Height = 129
      Hint = ''
      TextConversion = txtHTML
      AutoSize = False
      Caption = 
        'Este assistente ir'#225' gui'#225'-lo passo a passo no processo de registr' +
        'o de um novo dom'#237'nio no sistema.<br><br>Um dom'#237'nio representa a ' +
        'empresa, organiza'#231#227'o ou ambiente ao qual o usu'#225'rio pertence dent' +
        'ro do sistema. Ele '#233' utilizado para separar e identificar os dad' +
        'os, usu'#225'rios, permiss'#245'es e configura'#231#245'es de cada empresa de form' +
        'a independente.<br><br>Voc'#234' s'#243' precisa seguir as etapas, preench' +
        'er as informa'#231#245'es solicitadas e avan'#231'ar quando estiver pronto.'
      TabOrder = 2
    end
    object labTitle: TUniLabel
      Left = 3
      Top = 8
      Width = 268
      Height = 21
      Hint = ''
      Caption = 'Bem-vindo ao Registro de Dom'#237'nio'
      ParentFont = False
      Font.Height = -16
      Font.Style = [fsBold]
      TabOrder = 1
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
      OnExecute = actFinishExecute
    end
    object actNext: TAction
      Caption = 'Avan'#231'ar >'
      OnExecute = actNextExecute
    end
    object actNewCity: TAction
      Enabled = False
      ImageIndex = 0
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
