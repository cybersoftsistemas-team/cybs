inherited damLogin: TdamLogin
  OnCreate = UniGUIMainModuleCreate
  Height = 159
  Width = 311
  object mtbUSE: TFDMemTable
    OnNewRecord = mtbUSENewRecord
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
    ResourceOptions.StoreItems = [siData, siDelta]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
    object mtbUSEId: TGuidField
      FieldName = 'Id'
      Visible = False
      Size = 38
    end
    object mtbUSEName: TStringField
      DisplayLabel = 'Nome de usu'#225'rio'
      FieldName = 'Name'
      Size = 255
    end
    object mtbUSEPassword: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'Password'
      Size = 255
    end
    object mtbUSEDomainId: TGuidField
      FieldName = 'DomainId'
      Size = 38
    end
    object mtbUSEDomainName: TStringField
      FieldName = 'DomainName'
      Size = 255
    end
  end
  object dsoUSE: TDataSource
    DataSet = mtbUSE
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 104
    Top = 16
  end
  object mtbCNS: TFDMemTable
    AfterOpen = mtbCNSAfterOpen
    AfterPost = mtbCNSAfterPost
    BeforeDelete = mtbCNSBeforeDelete
    AfterDelete = mtbCNSAfterDelete
    OnNewRecord = mtbCNSNewRecord
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvStoreItems, rvSilentMode]
    ResourceOptions.StoreItems = [siData, siDelta]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 88
    object mtbCNSId: TGuidField
      FieldName = 'Id'
      Visible = False
      Size = 38
    end
    object mtbCNSName: TStringField
      DisplayLabel = 'Nome da conex'#227'o'
      DisplayWidth = 18
      FieldName = 'Name'
      Size = 255
    end
    object mtbCNSConnectionString: TStringField
      DisplayWidth = 120
      FieldName = 'ConnectionString'
      Size = 255
    end
  end
  object dsoCNS: TDataSource
    DataSet = mtbCNS
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 104
    Top = 88
  end
  object qryCMR: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',CustomerId'
      ',ClientId'
      ',CreatedAt'
      'FROM registration.customer;')
    Left = 176
    Top = 16
    object qryCMRId: TIntegerField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryCMRCustomerId: TGuidField
      FieldName = 'CustomerId'
      Origin = 'CustomerId'
      Required = True
      Size = 38
    end
    object qryCMRClientId: TGuidField
      FieldName = 'ClientId'
      Origin = 'ClientId'
      Required = True
      Size = 38
    end
    object qryCMRCreatedAt: TSQLTimeStampField
      FieldName = 'CreatedAt'
      Origin = 'CreatedAt'
      Required = True
    end
  end
  object dsoCMR: TDataSource
    DataSet = qryCMR
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 248
    Top = 16
  end
end
