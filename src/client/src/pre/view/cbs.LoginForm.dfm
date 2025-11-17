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
  TextHeight = 15
  inherited pnlAuthenticate: TUniPanel
    inherited pnlBody: TUniSimplePanel
      inherited edtUserName: TUniDBEdit
        DataSource = damLogin.dsoUSE
      end
      inherited edtPassword: TUniDBEdit
        DataSource = damLogin.dsoUSE
      end
    end
  end
end
