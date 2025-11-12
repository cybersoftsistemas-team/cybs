inherited cbsServerModule: TcbsServerModule
  OnCreate = UniGUIServerModuleCreate
  CustomFiles.Strings = (
    'window.isElectron = !!window.electronAPI;')
end
