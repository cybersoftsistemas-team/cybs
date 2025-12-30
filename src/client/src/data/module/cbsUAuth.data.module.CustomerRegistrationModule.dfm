inherited damCustomerRegistration: TdamCustomerRegistration
  Height = 229
  Width = 636
  object qryLEG: TFDQuery
    BeforePost = DataSetBeforePost
    OnNewRecord = qryLEGNewRecord
    CachedUpdates = True
    Connection = damDb.Connection
    UpdateObject = updLEG
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      ',DoingBusinessAs'
      ',CRN'
      ',FoundationDate'
      ',StateInscriptionNumber'
      ',MunicipalInscription'
      ',CompanyTypeId'
      ',NationalityId'
      ',StateId'
      'FROM person.legals'
      'WHERE Id = :Id;')
    Left = 22
    Top = 15
    ParamData = <
      item
        Name = 'ID'
        DataType = ftGuid
        ParamType = ptInput
        Value = Null
      end>
    object qryLEGId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryLEGName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qryLEGDoingBusinessAs: TWideStringField
      FieldName = 'DoingBusinessAs'
      Origin = 'DoingBusinessAs'
      Required = True
      Size = 255
    end
    object qryLEGCRN: TWideStringField
      FieldName = 'CRN'
      Origin = 'CRN'
      Required = True
      Size = 14
    end
    object qryLEGFoundationDate: TSQLTimeStampField
      FieldName = 'FoundationDate'
      Origin = 'FoundationDate'
      Required = True
    end
    object qryLEGStateInscriptionNumber: TWideStringField
      FieldName = 'StateInscriptionNumber'
      Origin = 'StateInscriptionNumber'
    end
    object qryLEGMunicipalInscription: TWideStringField
      FieldName = 'MunicipalInscription'
      Origin = 'MunicipalInscription'
    end
    object qryLEGCompanyTypeId: TGuidField
      FieldName = 'CompanyTypeId'
      Origin = 'CompanyTypeId'
      Required = True
      Size = 38
    end
    object qryLEGNationalityId: TGuidField
      FieldName = 'NationalityId'
      Origin = 'NationalityId'
      Required = True
      Size = 38
    end
    object qryLEGStateId: TGuidField
      FieldName = 'StateId'
      Origin = 'StateId'
      Size = 38
    end
  end
  object qryNAT: TFDQuery
    BeforePost = DataSetBeforePost
    OnNewRecord = qryNATNewRecord
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
    InsertSQL.Strings = (
      'INSERT INTO person.legals'
      '(Id'
      ',Name'
      ',DoingBusinessAs'
      ',CRN'
      ',FoundationDate'
      ',StateInscriptionNumber'
      ',MunicipalInscription'
      ',CompanyTypeId'
      ',NationalityId'
      ',StateId)'
      'VALUES '
      '(:NEW_Id'
      ',:NEW_Name'
      ',:NEW_DoingBusinessAs'
      ',:NEW_CRN'
      ',:NEW_FoundationDate'
      ',:NEW_StateInscriptionNumber'
      ',:NEW_MunicipalInscription'
      ',:NEW_CompanyTypeId'
      ',:NEW_NationalityId'
      ',:NEW_StateId);'
      'SELECT Id '
      ',Name'
      ',DoingBusinessAs'
      ',CRN'
      ',FoundationDate'
      ',StateInscriptionNumber'
      ',MunicipalInscription'
      ',CompanyTypeId'
      ',NationalityId'
      ',StateId'
      'FROM person.legals'
      'WHERE Id = :NEW_Id;')
    ModifySQL.Strings = (
      'UPDATE person.legals'
      'SET Name = :NEW_Name'
      ',DoingBusinessAs = :NEW_DoingBusinessAs'
      ',CRN = :NEW_CRN'
      ',FoundationDate = :NEW_FoundationDate'
      ',StateInscriptionNumber = :NEW_StateInscriptionNumber'
      ',MunicipalInscription = :NEW_MunicipalInscription'
      ',CompanyTypeId = :NEW_CompanyTypeId'
      ',NationalityId = :NEW_NationalityId'
      ',StateId = :NEW_StateId'
      'WHERE Id = :OLD_Id;'
      'SELECT Id '
      ',Name'
      ',DoingBusinessAs'
      ',CRN'
      ',FoundationDate'
      ',StateInscriptionNumber'
      ',MunicipalInscription'
      ',CompanyTypeId'
      ',NationalityId'
      ',StateId'
      'FROM person.legals'
      'WHERE Id = :NEW_Id;')
    DeleteSQL.Strings = (
      '')
    FetchRowSQL.Strings = (
      'SELECT Id '
      ',Name'
      ',DoingBusinessAs'
      ',CRN'
      ',FoundationDate'
      ',StateInscriptionNumber'
      ',MunicipalInscription'
      ',CompanyTypeId'
      ',NationalityId'
      ',StateId'
      'FROM person.legals'
      'WHERE Id = :OLD_Id;')
    Left = 90
    Top = 15
  end
  object updNAT: TFDUpdateSQL
    Connection = damDb.Connection
    InsertSQL.Strings = (
      'INSERT INTO person.naturals'
      '(Id'
      ',FirstName'
      ',LastName'
      ',Birthday'
      ',SSN'
      ',IDCard'
      ',PlaceOfBirthId'
      ',NationalityId'
      ',GenderId)'
      'VALUES '
      '(:NEW_Id'
      ',:NEW_FirstName'
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
      'UPDATE person.naturals'
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
  object qryCTP: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      'FROM general.categories'
      'WHERE ParentId = '#39'E3A2C0C9-42B8-4F6D-B6E7-5E5FE0F3C2A1'#39';')
    Left = 230
    Top = 160
    object qryCTPId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryCTPName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
  end
  object dsoCTP: TDataSource
    DataSet = qryCTP
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 298
    Top = 160
  end
  object qryNTY: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT NAT.Id'
      ',NAT.Name'
      ',NAT.CountryId'
      'FROM person.nationalities AS NAT;')
    Left = 368
    Top = 160
    object qryNTYId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryNTYName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qryNTYCountryId: TGuidField
      FieldName = 'CountryId'
      Origin = 'CountryId'
      Size = 38
    end
  end
  object dsoNTY: TDataSource
    DataSet = qryNTY
    OnStateChange = dsoStateChange
    OnDataChange = dsoDataChange
    Left = 438
    Top = 160
  end
  object qrySTE: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      'FROM address.states'
      'WHERE CountryId = '#39'9F6E6D3A-1F5A-4C8C-9C9E-55B55E55B555'#39';')
    Left = 510
    Top = 15
    object qrySTEId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qrySTEName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
  end
  object dsoSTE: TDataSource
    DataSet = qrySTE
    Left = 576
    Top = 15
  end
end
