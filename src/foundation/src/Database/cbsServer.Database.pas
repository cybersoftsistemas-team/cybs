unit cbsServer.Database;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Migrations.MigrationContextBase,
  cbsSystem.Database,
  cbsSystem.Infrastructure.BaseDbModule;

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
  cbsSystem.Support.DatabaseSeederTypeRepository;

{ TDatabase }

procedure TDatabase.BeforeExecuteMigrations;
begin
  inherited;
  RegisterMigrations;
end;

procedure TDatabase.InternalExecuteMigrations(const TDbModule: DbConnectionModuleType; const TDbMigrationContext: MigrationContextType);
begin
  try
    if Assigned(TDbModule) and Assigned(TDbMigrationContext) then
    begin
      var LdamDb := TDbModule.Create(nil);
      var LConnection := LdamDb.Connection;
      try
        LConnection.StartTransaction;
        try
          var LDbContext := TDbMigrationContext.Create;
          try
            LDbContext.Connection := LConnection;
            LDbContext.UpdateDatabase;
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
        LConnection.StartTransaction;
        try
          for var LDatabaseSeederType in DatabaseSeederTypeRepository do
          begin
            var LDatabaseSeeder := CreateObject(LDatabaseSeederType).AsType<IDatabaseSeeder>;
            try
              LDatabaseSeeder.Run;
            finally
              LDatabaseSeeder := nil;
            end;
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
  except
  end;
end;

procedure TDatabase.OnExecuteMigrations;
begin
  inherited;
  InternalExecuteMigrations(TdamDb, TDbContext);
end;

end.
