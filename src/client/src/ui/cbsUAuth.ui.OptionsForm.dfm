inherited frmOptions: TfrmOptions
  ClientHeight = 348
  ClientWidth = 451
  BorderStyle = bsDialog
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'   if' +
      ' (AppEnv.isElectron()) {'#13#10'      sender.addCls("electron-login-op' +
      'tions-pos");'#13#10'   }'#13#10'}')
  ExplicitWidth = 467
  ExplicitHeight = 387
  TextHeight = 15
  object grdConn: TUniDBGrid [0]
    Left = 10
    Top = 26
    Width = 320
    Height = 312
    Hint = ''
    Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAutoRefreshRow]
    WebOptions.Paged = False
    LoadMask.Message = 'Loading data...'
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
  object labConnList: TUniLabel [1]
    Left = 10
    Top = 7
    Width = 200
    Height = 13
    Hint = ''
    Caption = 'Lista de conex'#245'es de bancos de dados:'
    TabOrder = 1
  end
  object btnAdd: TUniBitBtn [2]
    Left = 342
    Top = 26
    Width = 96
    Height = 25
    Action = actAdd
    TabOrder = 2
  end
  object btnEdit: TUniBitBtn [3]
    Left = 342
    Top = 57
    Width = 96
    Height = 25
    Action = actEdit
    TabOrder = 3
  end
  object btnDel: TUniBitBtn [4]
    Left = 342
    Top = 88
    Width = 96
    Height = 25
    Action = actDel
    TabOrder = 4
  end
  object btnClear: TUniBitBtn [5]
    Left = 342
    Top = 119
    Width = 96
    Height = 25
    Action = actClear
    TabOrder = 5
  end
  inherited aclMain: TUniActionList
    object actAdd: TAction
      Caption = 'Adicionar'
    end
    object actEdit: TAction
      Caption = 'Alterar'
    end
    object actDel: TAction
      Caption = 'Excluir'
    end
    object actClear: TAction
      Caption = 'Limpar'
    end
  end
end
