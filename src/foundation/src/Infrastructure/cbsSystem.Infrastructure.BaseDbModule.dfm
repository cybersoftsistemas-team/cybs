inherited damBaseDb: TdamBaseDb
  Height = 86
  Width = 445
  object Connection: TFDConnection
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
  object sptSeed: TFDScript
    SQLScripts = <
      item
        Name = 'root'
      end>
    Connection = Connection
    Params = <>
    Macros = <>
    Left = 384
    Top = 16
  end
end
