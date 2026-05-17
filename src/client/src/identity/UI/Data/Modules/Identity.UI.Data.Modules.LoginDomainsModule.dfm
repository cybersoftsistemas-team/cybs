inherited damLoginDomains: TdamLoginDomains
  Height = 86
  Width = 95
  object mtbDOM: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 31
    Top = 16
    object mtbDOMId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
      Size = 38
    end
    object mtbDOMName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object mtbDOMParentId: TGuidField
      FieldName = 'ParentId'
      Origin = 'ParentId'
      Visible = False
      Size = 38
    end
  end
end
