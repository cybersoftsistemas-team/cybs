inherited damCustomerRegistration: TdamCustomerRegistration
  Height = 229
  Width = 497
  object qryLEG: TFDQuery
    BeforePost = DataSetBeforePost
    CachedUpdates = True
    Connection = damDb.Connection
    UpdateObject = updLEG
    Left = 22
    Top = 15
  end
  object qryNAT: TFDQuery
    BeforePost = DataSetBeforePost
    CachedUpdates = True
    Connection = damDb.Connection
    UpdateObject = updNAT
    SQL.Strings = (
      'SELECT Id'
      ',FirstName'
      ',LastName'
      ',Birthday'
      ',SSN'
      ',IDCard'
      ',PlaceOfBirthId'
      ',NationalityId'
      ',GenderId'
      'FROM person.naturals'
      'WHERE Id = :Id;')
    Left = 22
    Top = 87
    ParamData = <
      item
        Name = 'ID'
        DataType = ftGuid
        ParamType = ptInput
        Value = Null
      end>
    object qryNATId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryNATFirstName: TWideStringField
      FieldName = 'FirstName'
      Origin = 'FirstName'
      Required = True
      Size = 127
    end
    object qryNATLastName: TWideStringField
      FieldName = 'LastName'
      Origin = 'LastName'
      Size = 127
    end
    object qryNATBirthday: TSQLTimeStampField
      FieldName = 'Birthday'
      Origin = 'Birthday'
    end
    object qryNATIDCard: TWideStringField
      FieldName = 'IDCard'
      Origin = 'IDCard'
      Size = 15
    end
    object qryNATSSN: TWideStringField
      FieldName = 'SSN'
      Origin = 'SSN'
      Required = True
      Size = 11
    end
    object qryNATPlaceOfBirthId: TGuidField
      FieldName = 'PlaceOfBirthId'
      Origin = 'PlaceOfBirthId'
      Size = 38
    end
    object qryNATNationalityId: TGuidField
      FieldName = 'NationalityId'
      Origin = 'NationalityId'
      Size = 38
    end
    object qryNATGenderId: TGuidField
      FieldName = 'GenderId'
      Origin = 'GenderId'
      Size = 38
    end
  end
  object updLEG: TFDUpdateSQL
    Connection = damDb.Connection
    Left = 90
    Top = 15
  end
  object updNAT: TFDUpdateSQL
    Connection = damDb.Connection
    InsertSQL.Strings = (
      'INSERT INTO CYBS.person.naturals'
      '(FirstName'
      ',LastName'
      ',Birthday'
      ',SSN'
      ',IDCard'
      ',PlaceOfBirthId'
      ',NationalityId'
      ',GenderId)'
      'VALUES '
      '(:NEW_FirstName'
      ',:NEW_LastName'
      ',:NEW_Birthday'
      ',:NEW_SSN'
      ',:NEW_IDCard'
      ',:NEW_PlaceOfBirthId'
      ',:NEW_NationalityId'
      ',:NEW_GenderId);'
      'SELECT Id'
      ',FirstName'
      ',LastName'
      ',Birthday'
      ',SSN'
      ',IDCard'
      ',PlaceOfBirthId'
      ',NationalityId'
      ',GenderId'
      'FROM person.naturals'
      'WHERE Id = :NEW_Id;')
    ModifySQL.Strings = (
      'UPDATE CYBS.person.naturals'
      'SET FirstName = :NEW_FirstName'
      ',LastName = :NEW_LastName'
      ',Birthday = :NEW_Birthday'
      ',SSN = :NEW_SSN'
      ',IDCard = :NEW_IDCard'
      ',PlaceOfBirthId = :NEW_PlaceOfBirthId'
      ',NationalityId = :NEW_NationalityId'
      ',GenderId = :NEW_GenderId'
      'WHERE Id = :OLD_Id;'
      'SELECT Id'
      ',FirstName'
      ',LastName'
      ',Birthday'
      ',SSN'
      ',IDCard'
      ',PlaceOfBirthId'
      ',NationalityId'
      ',GenderId'
      'FROM person.naturals'
      'WHERE Id = :NEW_Id;')
    DeleteSQL.Strings = (
      '')
    FetchRowSQL.Strings = (
      'SELECT Id'
      ',FirstName'
      ',LastName'
      ',Birthday'
      ',SSN'
      ',IDCard'
      ',PlaceOfBirthId'
      ',NationalityId'
      ',GenderId'
      'FROM person.naturals'
      'WHERE Id = :OLD_Id;')
    Left = 90
    Top = 87
  end
  object dsoLEG: TDataSource
    DataSet = qryLEG
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 160
    Top = 15
  end
  object dsoNAT: TDataSource
    DataSet = qryNAT
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 160
    Top = 87
  end
  object qryGEN: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      ',Reserved'
      ',ParentId'
      'FROM general.categories'
      'WHERE ParentId = '#39'6A1D9EBC-25E9-4F39-B9C5-8D8766A2F4C7'#39';')
    Left = 230
    Top = 15
    object qryGENId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryGENName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qryGENReserved: TBooleanField
      FieldName = 'Reserved'
      Origin = 'Reserved'
      Required = True
    end
    object qryGENParentId: TGuidField
      FieldName = 'ParentId'
      Origin = 'ParentId'
      Size = 38
    end
  end
  object dsoGEN: TDataSource
    DataSet = qryGEN
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 298
    Top = 15
  end
  object qryNTU: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT NAT.Id'
      ',NAT.Name'
      ',NAT.CountryId'
      'FROM person.nationalities AS NAT')
    Left = 230
    Top = 87
    object qryNTUId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryNTUName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qryNTUCountryId: TGuidField
      FieldName = 'CountryId'
      Origin = 'CountryId'
      Size = 38
    end
  end
  object dsoNTU: TDataSource
    DataSet = qryNTU
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 298
    Top = 87
  end
  object qryCOU: TFDQuery
    CachedUpdates = True
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      ',AreaCode'
      'FROM address.countries;')
    Left = 368
    Top = 15
    object qryCOUId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryCOUName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qryCOUAreaCode: TIntegerField
      FieldName = 'AreaCode'
      Origin = 'AreaCode'
    end
  end
  object dsoCOU: TDataSource
    DataSet = qryCOU
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 438
    Top = 15
  end
  object qrySTA: TFDQuery
    CachedUpdates = True
    MasterSource = dsoCOU
    MasterFields = 'Id'
    DetailFields = 'CountryId'
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      ',Acronym'
      ',CountryId'
      'FROM address.states'
      'WHERE CountryId = :Id;')
    Left = 368
    Top = 87
    ParamData = <
      item
        Name = 'ID'
        DataType = ftGuid
        ParamType = ptInput
        Value = Null
      end>
    object qrySTAId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qrySTAName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qrySTAAcronym: TWideStringField
      FieldName = 'Acronym'
      Origin = 'Acronym'
      Size = 10
    end
    object qrySTACountryId: TGuidField
      FieldName = 'CountryId'
      Origin = 'CountryId'
      Required = True
      Size = 38
    end
  end
  object dsoSTA: TDataSource
    DataSet = qrySTA
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 438
    Top = 87
  end
  object qryCYT: TFDQuery
    BeforePost = DataSetBeforePost
    OnNewRecord = qryCYTNewRecord
    CachedUpdates = True
    MasterSource = dsoSTA
    MasterFields = 'Id'
    DetailFields = 'StateId'
    Connection = damDb.Connection
    UpdateObject = updCYT
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      ',AreaCode'
      ',StateId'
      'FROM address.cities'
      'WHERE StateId = :Id;')
    Left = 22
    Top = 160
    ParamData = <
      item
        Name = 'ID'
        DataType = ftGuid
        ParamType = ptInput
        Value = Null
      end>
    object qryCYTId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryCYTName: TWideStringField
      DisplayLabel = 'Cidade'
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qryCYTAreaCode: TIntegerField
      DisplayLabel = 'DDD'
      FieldName = 'AreaCode'
      Origin = 'AreaCode'
      Required = True
    end
    object qryCYTStateId: TGuidField
      FieldName = 'StateId'
      Origin = 'StateId'
      Required = True
      Size = 38
    end
  end
  object dsoCYT: TDataSource
    DataSet = qryCYT
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 160
    Top = 160
  end
  object updCYT: TFDUpdateSQL
    Left = 90
    Top = 160
  end
end
