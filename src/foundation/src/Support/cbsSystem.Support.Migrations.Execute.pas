unit cbsSystem.Support.Migrations.Execute;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMigrationsFireDac.Migrations.MigrationContextBase,
  cbsSystem.Infrastructure.BaseDbModule;

  procedure InternalExecuteMigrations(const TdamDb: DbConnectionModuleType; const TDbContext: MigrationContextType);

implementation

procedure InternalExecuteMigrations(const TdamDb: DbConnectionModuleType; const TDbContext: MigrationContextType);
begin
  if Assigned(TdamDb) then
  begin
    var LdamDb := TdamDb.Create(nil);
    try
      var LConnection := LdamDb.Connection;
      if Assigned(TDbContext) then
      begin
        LConnection.StartTransaction;
        try
          var LDbContext := TDbContext.Create;
          try
            LDbContext.Connection := LConnection;
            LDbContext.UpdateDatabase{(LdamDb.RunSeed)};
          finally
            FreeAndNil(LDbContext);
          end;
        except
          on E: Exception do
          begin
            LConnection.Rollback;
            raise Exception.Create(E.Message);
          end;
        end;
        LConnection.Commit;
      end;
    finally
      FreeAndNil(LdamDb);
    end;
  end;
end;

end.
