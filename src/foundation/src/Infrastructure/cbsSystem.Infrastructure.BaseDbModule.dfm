inherited damBaseDb: TdamBaseDb
  Height = 86
  Width = 384
  object Connection: TFDConnection
    ResourceOptions.AssignedValues = [rvAutoReconnect]
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    BeforeConnect = ConnectionBeforeConnect
    Left = 37
    Top = 16
  end
  object PhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 152
    Top = 16
  end
  object StanStorageBinLink: TFDStanStorageBinLink
    Left = 288
    Top = 16
  end
end
