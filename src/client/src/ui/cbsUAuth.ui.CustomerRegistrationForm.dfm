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
  object btnFinish: TUniBitBtn [0]
    Left = 270
    Top = 312
    Width = 80
    Height = 25
    Action = actFinish
    Anchors = [akRight, akBottom]
    TabOrder = 0
    IconAlign = iaRight
  end
  object btnNext: TUniBitBtn [1]
    Left = 184
    Top = 312
    Width = 80
    Height = 25
    Action = actNext
    Anchors = [akRight, akBottom]
    TabOrder = 1
    IconAlign = iaRight
  end
  object btnBack: TUniBitBtn [2]
    Left = 98
    Top = 312
    Width = 80
    Height = 25
    Action = actBack
    Anchors = [akRight, akBottom]
    TabOrder = 2
  end
  object pnlLine02: TUniPanel [3]
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
    Caption = 'UniPanel1'
  end
  object btnCancel: TUniBitBtn [4]
    Left = 360
    Top = 312
    Width = 80
    Height = 25
    Action = actCancel
    Cancel = True
    ModalResult = 2
    Anchors = [akRight, akBottom]
    TabOrder = 4
    IconAlign = iaRight
  end
  inherited aclMain: TUniActionList
    object actBack: TAction
      Caption = '< Voltar'
    end
    object actCancel: TAction
      Caption = 'Cancelar'
    end
    object actFinish: TAction
      Caption = 'Finalizar >>|'
    end
    object actNext: TAction
      Caption = 'Pr'#243'ximo >'
    end
  end
  inherited nilstMain: TUniNativeImageList
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
