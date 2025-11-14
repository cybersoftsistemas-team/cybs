inherited cbsMainForm: TcbsMainForm
  PageMode = True
  ClientEvents.UniEvents.Strings = (
    
      'window.afterCreate=function window.afterCreate(sender)'#13#10'{'#13#10'    v' +
      'ar isElectron = navigator.userAgent.indexOf("Electron") >= 0;'#13#10' ' +
      '   ajaxRequest(sender, "IsElectron", ["value=" + isElectron]);'#13#10 +
      '}')
  OnAjaxEvent = UniFormAjaxEvent
  TextHeight = 15
end
