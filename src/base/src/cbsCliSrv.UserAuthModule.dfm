inherited cbsCliSrvUserAuthModule: TcbsCliSrvUserAuthModule
  OnCreate = UniGUIMainModuleCreate
  object mtbUSE: TFDMemTable
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
  end
  object dsoUSE: TDataSource
    DataSet = mtbUSE
    Left = 104
    Top = 16
  end
end
