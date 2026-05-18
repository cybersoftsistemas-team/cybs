inherited damIdentityDbSeed: TdamIdentityDbSeed
  inherited sptSeed: TFDScript
    Connection = damDb.Connection
    ScriptOptions.BreakOnError = True
    Params = <
      item
        Name = 'AccountDisabledId'
        DataType = ftGuid
        ParamType = ptInput
      end
      item
        Name = 'AdministratorId'
        DataType = ftGuid
        ParamType = ptInput
      end
      item
        Name = 'ChangePasswordOnNextLoginId'
        DataType = ftGuid
        ParamType = ptInput
      end
      item
        Name = 'PasswordNeverExpires'
        DataType = ftGuid
        ParamType = ptInput
      end
      item
        Name = 'UserCannotChangeThePasswordId'
        DataType = ftGuid
        ParamType = ptInput
      end>
  end
end
