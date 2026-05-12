unit cbsServer.Database;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Migrations.MigrationContextBase,
  cbsSystem.Contracts.Database.Persistence,
  cbsSystem.Contracts.Module.ServerModule,
  cbsSystem.Database,
  cbsSystem.Infrastructure.BaseDbModule;

type
  TDatabase = class(TcbsDatabase)
  private
    FPersistence: IPersistence;
    procedure InternalExecuteMigrations(const TDbModule: DbConnectionModuleType; const TDbMigrationContext: MigrationContextType);
  protected
    function GetPersistence: IPersistence; override;
    procedure OnExecuteMigrations; override;
  public
    constructor Create(const AOwner: IServerModule; const TDbModule: DbConnectionModuleType);
    destructor Destroy; override;
    property Persistence;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.Database.Seeders.DatabaseSeeder,
  cbsSystem.Database.Persistence,
  cbsSystem.Reflection,
  cbsSystem.Support.Container,
  cbsSystem.Support.DatabaseSeederTypeRepository,
  Shared.Inf.Database.Connection,
  Shared.Inf.Database.Context;

{ TDatabase }

constructor TDatabase.Create(const AOwner: IServerModule; const TDbModule: DbConnectionModuleType);
begin
  inherited Create(AOwner);
  FPersistence := TPersistence.Create(TDbModule);
end;

destructor TDatabase.Destroy;
begin
  FPersistence := nil;
  inherited;
end;

function TDatabase.GetPersistence: IPersistence;
begin
  Result := FPersistence;
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
          for var LSeeder in App.MakeAll<IDatabaseSeeder> do
          begin
            LSeeder.Run;
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
