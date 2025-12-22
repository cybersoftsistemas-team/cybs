unit cbsServer.Database;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Migrations.MigrationContextBase,
  cbsSystem.Infrastructure.BaseDbModule,
  cbsSystem.Database;

type
  TDatabase = class(TcbsDatabase)
  private
    procedure InternalExecuteMigrations(const TDbModule: DbConnectionModuleType; const TDbMigrationContext: MigrationContextType);
  protected
    procedure BeforeExecuteMigrations; override;
    procedure OnExecuteMigrations; override;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMain.inf.DbContext,
  cbsMain.inf.DbModule,
  cbsMain.support.RegisterMigrations,
  cbsSystem.Contracts.Database.Seeders.DatabaseSeeder,
  cbsSystem.Reflection,
  cbsSystem.Support.DatabaseSeederRepository;

{ TDatabase }

procedure TDatabase.BeforeExecuteMigrations;
begin
  inherited;
  RegisterMigrations;
end;

procedure TDatabase.InternalExecuteMigrations(const TDbModule: DbConnectionModuleType; const TDbMigrationContext: MigrationContextType);
begin
  if Assigned(TDbModule) and Assigned(TDbMigrationContext) then
  begin
    var LdamDb := TDbModule.Create(nil);
    try
      var LConnection := LdamDb.Connection;
      LConnection.StartTransaction;
      try
        var LDbContext := TDbMigrationContext.Create;
        try
          LDbContext.Connection := LConnection;
          LDbContext.UpdateDatabase(
            procedure
            begin
              for var LDatabaseSeederType in DatabaseSeederRepository do
              begin
                var LDatabaseSeeder := CreateObject(LDatabaseSeederType).AsType<IDatabaseSeeder>;
                try
                  LDatabaseSeeder.Run;
                finally
                  LDatabaseSeeder := nil;
                end;
              end;
            end);
        finally
          FreeAndNil(LDbContext);
        end;
        LConnection.Commit;
      except
        on E: Exception do
        begin
          LConnection.Rollback;
          raise Exception.Create(E.Message);
        end;
      end;
    finally
      FreeAndNil(LdamDb);
    end;
  end;
end;

procedure TDatabase.OnExecuteMigrations;
begin
  inherited;
  InternalExecuteMigrations(TdamDb, TDbContext);
end;

end.
