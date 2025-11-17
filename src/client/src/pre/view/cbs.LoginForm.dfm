inherited frmLogin: TfrmLogin
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{       ' +
      '                      '#13#10'    var inElectron = AppEnv.isElectron()' +
      ';'#13#10#13#10'    // manda para o Delphi'#13#10'    ajaxRequest(sender, "IsElec' +
      'tron", ["value=" + inElectron]);'#13#10'    '#13#10'    if (AppEnv.isElectro' +
      'n()) {'#13#10'        sender.addCls("electron-login-pos");'#13#10'    }'#13#10'   ' +
      ' '#13#10'    loadData(sender, "logon.dat");'#13#10'}')
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
