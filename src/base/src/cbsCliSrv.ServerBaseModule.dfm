object cbsCliSrvBaseModule: TcbsCliSrvBaseModule
  TempFolder = 'temp\'
  Title = 'New Application'
  SuppressErrors = []
  Bindings = <>
  MainFormDisplayMode = mfPage
  CustomFiles.Strings = (
    'files\js\electron-env.js'
    'files\js\detect-env.js'
    'files\js\load-data.js')
  CustomCSS.Strings = (
    '/* Remove rolagem e espa'#231'amento do body */'
    'html, body {'
    '  margin: 0 !important;'
    '  padding: 0 !important;'
    '  overflow: hidden !important;'
    '  background: transparent !important;'
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
    '  user-select: none;'
    '  -webkit-user-select: none;'
    '  -ms-user-select: none;'
    '}'
    ''
    '/* '#55357#56481' Remove outline azul de foco em bot'#245'es */'
    'button:focus, .x-btn:focus {'
    '  outline: none !important;'
    '  box-shadow: none !important;'
    '}'
    ''
    '/* ============================================================'
    '   '#55357#56629' BARRA DE T'#205'TULO ESTILO WINDOWS 11'
    
      '   ============================================================ ' +
      '*/'
    '.cybs-titlebar {'
    '  height: 32px;'
    
      '  background: transparent;    /* deixa o tema decidir se tem cor' +
      ' */'
    '  display: flex;'
    '  flex-direction: row;'
    '  align-items: center;'
    '  justify-content: space-between;'
    '  -webkit-app-region: drag;   /* Permite arrastar no Electron */'
    '  padding: 0 0 0 12px;'
    '  user-select: none;'
    '  border-bottom: 1px solid rgba(255,255,255,0.08); /* Win11 */'
    '}'
    ''
    '/* T'#237'tulo */'
    '.cybs-titlebar .title {'
    '  font-size: 14px;'
    '  font-weight: 500;'
    '  color: inherit;'
    '}'
    ''
    '/* '#193'rea dos bot'#245'es */'
    '.cybs-titlebar .window-buttons {'
    '  display: flex;'
    '  flex-direction: row;'
    '  -webkit-app-region: no-drag;  /* impede arrasto nos bot'#245'es */'
    '}'
    ''
    '/* ============================================================'
    '   BOT'#213'ES WINDOWS '#8212' estado normal transparente'
    
      '   ============================================================ ' +
      '*/'
    '.x-btn.cybs-win-btn,'
    '.x-btn.cybs-win-btn .x-btn-wrap,'
    '.x-btn.cybs-win-btn .x-btn-button,'
    '.x-btn.cybs-win-btn .x-btn-inner {'
    '  background: transparent !important;'
    '  background-color: transparent !important;'
    '  border: none !important;'
    '  box-shadow: none !important;'
    '  color: inherit !important;'
    '  border-radius: 0 !important;'
    '  transition: background 150ms ease;'
    '}'
    ''
    '/* ============================================================'
    '   HOVER PARA MIN/MAX/RESTORE '#8212' universal (tema-like)'
    
      '   ============================================================ ' +
      '*/'
    '.x-btn.cybs-win-btn.cybs-min-btn.x-btn-over,'
    '.x-btn.cybs-win-btn.cybs-max-btn.x-btn-over,'
    '.x-btn.cybs-win-btn.cybs-restore-btn.x-btn-over {'
    
      '  background-color: rgba(0,0,0,0.08) !important;   /* para temas' +
      ' light */'
    '}'
    ''
    'body.x-nlg .x-btn.cybs-win-btn.x-btn-over,'
    'body.x-nlg .x-btn.cybs-win-btn.x-btn-over .x-btn-wrap {'
    
      '  background-color: rgba(255,255,255,0.12) !important; /* para t' +
      'emas dark */'
    '}'
    ''
    '/* ============================================================'
    '   BOT'#195'O FECHAR '#8212' hover vermelho fixo'
    
      '   ============================================================ ' +
      '*/'
    '.x-btn.cybs-close-btn.x-btn-over {'
    '  background-color: #e81123 !important;'
    '  color: #fff !important;'
    '}'
    ''
    '/* Centralizar */'
    '.x-btn.cybs-win-btn .x-btn-inner {'
    '  line-height: 1;'
    '  display: flex !important;'
    '  align-items: center !important;'
    '  justify-content: center !important;'
    '}'
    ''
    '.electron-login-pos {'
    '  position: absolute !important;'
    '  left: -4px !important;'
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
  Height = 276
  Width = 371
end
