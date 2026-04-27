inherited damIdentityConfig: TdamIdentityConfig
  Height = 87
  Width = 91
  object qryCON: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT *'
      'FROM [identity].[configs]'
      'WHERE Id = 1')
    Left = 30
    Top = 16
  end
end
