inherited frmOptions: TfrmOptions
  ClientHeight = 323
  ClientWidth = 449
  BorderStyle = bsDialog
  ExplicitWidth = 465
  ExplicitHeight = 362
  TextHeight = 15
  object grdConn: TUniDBGrid [0]
    Left = 8
    Top = 40
    Width = 329
    Height = 275
    Hint = ''
    Options = [dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAutoRefreshRow]
    WebOptions.Paged = False
    LoadMask.Message = 'Loading data...'
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
  end
end
