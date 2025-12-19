inherited damCustomerRegistration: TdamCustomerRegistration
  Height = 157
  Width = 227
  object qryPLE: TFDQuery
    Connection = damDb.Connection
    UpdateObject = updPLE
    Left = 22
    Top = 15
  end
  object qryPNA: TFDQuery
    Connection = damDb.Connection
    UpdateObject = updPNA
    Left = 22
    Top = 87
  end
  object updPLE: TFDUpdateSQL
    Connection = damDb.Connection
    Left = 90
    Top = 15
  end
  object updPNA: TFDUpdateSQL
    Connection = damDb.Connection
    Left = 90
    Top = 87
  end
  object dsoPLE: TDataSource
    DataSet = qryPLE
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 160
    Top = 16
  end
  object dsoPNA: TDataSource
    DataSet = qryPNA
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 160
    Top = 87
  end
end
