object cbsServerModule: TcbsServerModule
  OnCreate = UniGUIServerModuleCreate
  OnDestroy = UniGUIServerModuleDestroy
  TempFolder = 'temp\'
  Title = 'New Application'
  BGColorLogin = 15921906
  SuppressErrors = []
  Bindings = <>
  JQueryVersion = '3.7.1'
  MainFormDisplayMode = mfPage
  CustomFiles.Strings = (
    'files\js\electron-env.js'
    'files\js\detect-env.js'
    'files\js\data-storege.js')
  CustomCSS.Strings = (
    '/* Remove rolagem e espa'#231'amento do body */'
    'html, body {'
    '  margin: 0 !important;'
    '  padding: 0 !important;'
    '  overflow: hidden !important;'
    '  font-family: tahoma, arial, verdana, sans-serif;'
    '}'
    ''
    '/* '#55357#56594' Bloqueia sele'#231#227'o apenas em componentes n'#227'o edit'#225'veis */'
    'label,'
    '.x-label,'
    'button,'
    '.x-btn,'
    '.x-panel-body,'
    '.x-toolbar,'
    '.x-tab,'
    '.x-grid-header-ct,'
    '.title-btn {'
    '  -webkit-user-select: none;'
    '  -moz-user-select: none;'
    '  -ms-user-select: none;'
    '  user-select: none;'
    '}'
    ''
    '/* '#55357#56481' Remove outline azul de foco em bot'#245'es */'
    'button:focus, .x-btn:focus {'
    '  outline: none !important;'
    '  box-shadow: none !important;'
    '}'
    ''
    '.electron-login-pos,'
    '.electron-login-domains-pos,'
    '.electron-login-options-pos,'
    '.electron-login-options-conn-editor-pos {'
    '  position: absolute !important;'
    '  left: -5px !important;'
    '  top: -5px !important;'
    '}')
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvSSLv23
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1, sslvTLSv1_2]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  ConnectionFailureRecovery.ErrorMessage = 'Connection Error'
  ConnectionFailureRecovery.RetryMessage = 'Retrying...'
  Height = 159
  Width = 211
end
