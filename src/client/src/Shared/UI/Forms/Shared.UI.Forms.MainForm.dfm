inherited frmMain: TfrmMain
  Caption = 'frmMain'
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'    /' +
      '/ manda para o Electron (somente se estiver no Electron)'#13#10'    Ap' +
      'pEnv.safeSendToElectron("after-login", { w: 1024, h: 700 });'#13#10'}')
  TextHeight = 15
end
