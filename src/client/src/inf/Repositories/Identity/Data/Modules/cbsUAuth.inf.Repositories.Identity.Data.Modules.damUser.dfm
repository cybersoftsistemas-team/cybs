inherited damUser: TdamUser
  Height = 303
  Width = 230
  object qryBNA: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      ',AccessFailedCount'
      ',AccountActivated'
      ',AccountBlockedOut'
      ',LastLoginAt'
      ',LockoutEnd'
      ',PasswordHash'
      ',PasswordIterations'
      ',PasswordSalt'
      'FROM [identity].[users]'
      'WHERE Name = :UserName')
    Left = 23
    Top = 88
    ParamData = <
      item
        Name = 'USERNAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryBID: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT Id'
      ',Name'
      ',AccessFailedCount'
      ',AccountActivated'
      ',AccountBlockedOut'
      ',LastLoginAt'
      ',LockoutEnd'
      ',PasswordHash'
      ',PasswordIterations'
      ',PasswordSalt'
      'FROM [identity].[users]'
      'WHERE Id = :UserId')
    Left = 23
    Top = 16
    ParamData = <
      item
        Name = 'USERID'
        DataType = ftGuid
        ParamType = ptInput
        Value = Null
      end>
  end
  object cmdBIN: TFDCommand
    Connection = damDb.Connection
    CommandKind = skUpdate
    CommandText.Strings = (
      'UPDATE U'
      'SET '
      '    AccessFailedCount = CA.NewFailedCount,'
      '    LockoutEnd ='
      '      CASE '
      
        '        WHEN CA.NewFailedCount >= 5 THEN DATEADD(MINUTE, 15, GET' +
        'DATE())'
      '        ELSE U.LockoutEnd'
      '      END'
      'FROM [identity].[users] U'
      'CROSS APPLY ('
      '  SELECT U.AccessFailedCount + 1 AS NewFailedCount'
      ') CA'
      'WHERE U.Id = :UserId'
      'AND (U.LockoutEnd IS NULL OR U.LockoutEnd <= GETDATE());')
    ParamData = <
      item
        Name = 'USERID'
        ParamType = ptInput
      end>
    Left = 164
    Top = 16
  end
  object cmdBRE: TFDCommand
    Connection = damDb.Connection
    CommandKind = skUpdate
    CommandText.Strings = (
      'UPDATE [identity].[users]'
      'SET '
      '    AccessFailedCount = 0,'
      '    LastLoginAt = GETDATE(),'
      '    LockoutEnd = NULL'
      'WHERE Id = :UserId;')
    ParamData = <
      item
        Name = 'USERID'
        ParamType = ptInput
      end>
    Left = 164
    Top = 88
  end
  object cmdBLU: TFDCommand
    Connection = damDb.Connection
    CommandKind = skUpdate
    CommandText.Strings = (
      'UPDATE [identity].[users]'
      'SET '
      '    LockoutEnd = DATEADD(MINUTE, 15, GETDATE()),'
      '    AccessFailedCount = 0'
      'WHERE Id = :UserId;')
    ParamData = <
      item
        Name = 'USERID'
        ParamType = ptInput
      end>
    Left = 164
    Top = 160
  end
  object cmdBUP: TFDCommand
    Connection = damDb.Connection
    CommandKind = skUpdate
    CommandText.Strings = (
      'UPDATE [identity].[users] '
      'SET'
      '    PasswordHash = :Hash,'
      '    PasswordSalt = :Salt,'
      '    LastLoginAt = GETDATE(),'
      '    AccessFailedCount = 0,'
      '    LockoutEnd = NULL'
      'WHERE Id = :UserId;')
    ParamData = <
      item
        Name = 'HASH'
        ParamType = ptInput
      end
      item
        Name = 'SALT'
        ParamType = ptInput
      end
      item
        Name = 'USERID'
        ParamType = ptInput
      end>
    Left = 164
    Top = 232
  end
  object qryBSE: TFDQuery
    MasterSource = dsoBNA
    MasterFields = 'Id'
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT o.Id'
      ',o.Name'
      ',o.Description'
      ',s.Checked'
      'FROM [identity].settings s '
      'INNER JOIN [identity].options o '
      'ON s.OptionId = o.Id'
      'WHERE s.UserId = :Id;')
    Left = 23
    Top = 160
    ParamData = <
      item
        Name = 'ID'
        DataType = ftGuid
        ParamType = ptInput
        Value = Null
      end>
    object qryBSEId: TGuidField
      FieldName = 'Id'
      Origin = 'Id'
      Required = True
      Size = 38
    end
    object qryBSEName: TWideStringField
      FieldName = 'Name'
      Origin = 'Name'
      Required = True
      Size = 255
    end
    object qryBSEDescription: TWideMemoField
      FieldName = 'Description'
      Origin = 'Description'
      Required = True
      BlobType = ftWideMemo
      Size = 2147483647
    end
    object qryBSEChecked: TBooleanField
      FieldName = 'Checked'
      Origin = 'Checked'
      Required = True
    end
  end
  object dsoBID: TDataSource
    DataSet = qryBID
    Left = 89
    Top = 16
  end
  object dsoBNA: TDataSource
    DataSet = qryBNA
    Left = 89
    Top = 88
  end
end
