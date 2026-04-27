inherited damLoginDomains: TdamLoginDomains
  Height = 86
  Width = 93
  object qryDOM: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      ',ParentId'
      'FROM domain.domains'
      'ORDER BY ParentId, Name')
    Left = 31
    Top = 16
    object qryDOMId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
      Size = 38
    end
    object qryDOMName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qryDOMParentId: TGuidField
      FieldName = 'ParentId'
      Origin = 'ParentId'
      Visible = False
      Size = 38
    end
  end
end
