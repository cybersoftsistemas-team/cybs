inherited frmLogin: TfrmLogin
  ClientEvents.UniEvents.Strings = (
    
      'window.beforeInit=function window.beforeInit(sender, config)'#13#10'{'#13 +
      #10'    var inElectron = AppEnv.isElectron();'#13#10#13#10'    // manda para ' +
      'o Delphi'#13#10'    ajaxRequest(sender, "IsElectron", ["value=" + inEl' +
      'ectron]);'#13#10'}'
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{ '#13#10#9'if ' +
      '(AppEnv.isElectron()) {'#13#10'      sender.addCls("electron-login-pos' +
      '");'#13#10'   }'#13#10'    '#13#10'   window.DataStorage.load(sender, "logon.dat")' +
      ';'#13#10'}')
  OnCreate = UniLoginFormCreate
  TextHeight = 15
  inherited pnlAuthenticate: TUniPanel
    inherited pnlBody: TUniSimplePanel
      inherited edtUserName: TUniDBEdit
        DataSource = damLogin.dsoUSE
      end
      inherited edtPassword: TUniDBEdit
        DataSource = damLogin.dsoUSE
      end
      inherited btnConnect: TUniBitBtn
        Left = 259
        ExplicitLeft = 259
      end
      object btnOptions: TUniBitBtn
        Left = 345
        Top = 124
        Width = 75
        Height = 25
        Action = actOptions
        TabOrder = 6
        ImageIndex = 1
      end
    end
  end
  inherited aclMain: TUniActionList
    object actOptions: TAction
      Caption = 'Op'#231#245'es'
      ImageIndex = 1
    end
  end
end
