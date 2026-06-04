inherited damIdentityDbSeed: TdamIdentityDbSeed
  inherited sptSeed: TFDScript
    Connection = damDb.Connection
    ScriptOptions.BreakOnError = True
  end
end
