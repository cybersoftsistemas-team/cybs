object cbsCliSrvMainBaseForm: TcbsCliSrvMainBaseForm
  Left = 0
  Top = 0
  ClientHeight = 348
  ClientWidth = 464
  Caption = 'cbsCliSrvMainBaseForm'
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'    /' +
      '/ manda para o Electron (somente se estiver no Electron)'#13#10'    Ap' +
      'pEnv.safeSendToElectron("after-login", { w: 1024, h: 700 });'#13#10'}')
  TextHeight = 15
  object aclMain: TUniActionList
    Images = ilaMain
    Left = 364
    Top = 16
  end
  object ilaMain: TUniImageListAdapter
    UniImageList = nilstMain
    Left = 420
    Top = 16
  end
  object nilstMain: TUniNativeImageList
    Left = 392
    Top = 16
  end
end
