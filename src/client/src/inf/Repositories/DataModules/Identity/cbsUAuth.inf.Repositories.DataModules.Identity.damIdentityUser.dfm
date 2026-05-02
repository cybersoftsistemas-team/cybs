inherited damIdentityUser: TdamIdentityUser
  Height = 306
  Width = 225
  object qryBNA: TFDQuery
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT u.Id'
      ',u.Name'
      ',u.AccessFailedCount'
      ',u.AccountActivated'
      ',u.AccountBlockedOut'
      ',u.LastLoginAt'
      ',u.LockoutEnd'
      'FROM [identity].[users] u'
      'WHERE u.Name = :UserName;')
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
      'SELECT u.Id'
      ',u.Name'
      ',u.AccessFailedCount'
      ',u.AccountActivated'
      ',u.AccountBlockedOut'
      ',u.LastLoginAt'
      ',u.LockoutEnd'
      'FROM [identity].[users] u'
      'WHERE u.Id = :UserId;')
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
      '        WHEN CA.NewFailedCount >= C.MaxAttempts '
      '          THEN DATEADD(MINUTE, C.LockoutMinutes, GETDATE())'
      '        ELSE U.LockoutEnd'
      '      END'
      'FROM [identity].[users] U'
      'CROSS APPLY ('
      '  SELECT U.AccessFailedCount + 1 AS NewFailedCount'
      ') CA'
      'INNER JOIN [identity].[configs] C'
      '  ON C.Id = 1'
      'WHERE U.Id = :UserId'
      '  AND (U.LockoutEnd IS NULL OR U.LockoutEnd <= GETDATE());')
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
  object cmdBUP: TFDCommand
    Connection = damDb.Connection
    CommandKind = skUpdate
    CommandText.Strings = (
      'UPDATE [identity].[users] '
      'SET'
      '    AccessFailedCount = 0,    '
      '    LockoutEnd = NULL'
      'WHERE Id = :UserId;'
      ''
      'WITH Config AS ('
      '    SELECT PasswordIterations'
      '    FROM [identity].[configs]'
      '    WHERE Id = 1'
      '),'
      'SourceData AS ('
      '    SELECT '
      '         :UserId AS UserId'
      '        ,:Hash   AS Hash'
      '        ,:Salt   AS Salt'
      '        ,:Iterations AS IterationsFromParam'
      '        ,C.PasswordIterations AS IterationsFromConfig'
      '    FROM Config C'
      ')'
      'MERGE INTO [identity].[passwords] AS T'
      'USING SourceData AS S'
      'ON T.UserId = S.UserId'
      ''
      'WHEN MATCHED THEN'
      '    UPDATE SET'
      '         T.Hash       = S.Hash'
      '        ,T.Salt       = S.Salt'
      '        ,T.Iterations = S.IterationsFromParam'
      ''
      'WHEN NOT MATCHED THEN'
      '    INSERT (UserId, Hash, Iterations, Salt)'
      
        '    VALUES (S.UserId, S.Hash, S.IterationsFromConfig, S.Salt);  ' +
        ' '
      ''
      'UPDATE s'
      'SET Checked = :ChangePasswordOnNextLogin'
      'FROM [identity].[settings] s'
      'WHERE s.UserId = :UserId'
      'AND s.OptionId = :ChangePasswordOnNextLoginId'
      'AND Checked <> :ChangePasswordOnNextLogin;')
    ParamData = <
      item
        Name = 'USERID'
        DataType = ftGuid
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'HASH'
        DataType = ftBlob
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SALT'
        DataType = ftBlob
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ITERATIONS'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'CHANGEPASSWORDONNEXTLOGIN'
        ParamType = ptInput
      end
      item
        Name = 'CHANGEPASSWORDONNEXTLOGINID'
        ParamType = ptInput
      end>
    Left = 164
    Top = 160
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
    Left = 90
    Top = 16
  end
  object dsoBNA: TDataSource
    DataSet = qryBNA
    Left = 90
    Top = 88
  end
  object qryBPW: TFDQuery
    MasterSource = dsoBNA
    MasterFields = 'Id'
    Connection = damDb.Connection
    SQL.Strings = (
      'SELECT UserId'
      ',Hash'
      ',Iterations'
      ',Salt'
      'FROM [identity].[passwords]'
      'WHERE UserId = :Id;')
    Left = 23
    Top = 232
    ParamData = <
      item
        Name = 'ID'
        DataType = ftGuid
        ParamType = ptInput
        Value = Null
      end>
    object qryBPWUserId: TGuidField
      FieldName = 'UserId'
      Origin = 'UserId'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 38
    end
    object qryBPWHash: TVarBytesField
      FieldName = 'Hash'
      Origin = 'Hash'
      Required = True
      Size = 64
    end
    object qryBPWIterations: TIntegerField
      FieldName = 'Iterations'
      Origin = 'Iterations'
      Required = True
    end
    object qryBPWSalt: TVarBytesField
      FieldName = 'Salt'
      Origin = 'Salt'
      Required = True
      Size = 32
    end
  end
end
