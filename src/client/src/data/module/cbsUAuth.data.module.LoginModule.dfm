inherited damLogin: TdamLogin
  OnCreate = UniGUIMainModuleCreate
  Height = 159
  Width = 166
  object mtbUSE: TFDMemTable
    OnNewRecord = mtbUSENewRecord
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
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
    object mtbUSECnsId: TGuidField
      FieldName = 'CnsId'
      Size = 38
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
    OnNewRecord = mtbCNSNewRecord
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
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
      DisplayWidth = 30
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
end
