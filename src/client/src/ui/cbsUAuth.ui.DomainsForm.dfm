inherited frmDomains: TfrmDomains
  ClientHeight = 347
  ClientWidth = 451
  Caption = 'frmDomains'
  BorderStyle = bsNone
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'  if ' +
      '(AppEnv.isElectron()) {'#13#10'      sender.addCls("electron-login-dom' +
      'ains-pos");'#13#10'   }'#13#10'}')
  ExplicitWidth = 451
  ExplicitHeight = 347
  TextHeight = 15
  inherited btnOk: TUniBitBtn
    Left = 284
    Top = 312
    TabOrder = 2
    ExplicitLeft = 284
    ExplicitTop = 312
  end
  inherited btnCancel: TUniBitBtn
    Left = 365
    Top = 312
    TabOrder = 3
    ExplicitLeft = 365
    ExplicitTop = 312
  end
  object grdDomains: TUniDBTreeGrid [2]
    Left = 10
    Top = 27
    Width = 430
    Height = 276
    Hint = ''
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
    LoadMask.Message = 'Loading data...'
    Options = [dgColumnResize, dgColLines, dgRowLines, dgRowSelect]
    UseArrows = True
  end
  object labDomains: TUniLabel [3]
    Left = 10
    Top = 8
    Width = 176
    Height = 13
    Hint = ''
    Caption = 'Selecione uma empresa de acesso:'
    TabOrder = 0
  end
  inherited aclMain: TUniActionList
    Left = 351
  end
  inherited ilaMain: TUniImageListAdapter
    Left = 379
  end
  inherited nilstMain: TUniNativeImageList
    Left = 407
  end
end
