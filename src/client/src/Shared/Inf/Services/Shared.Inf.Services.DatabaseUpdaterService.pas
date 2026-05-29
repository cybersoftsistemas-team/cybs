unit Shared.Inf.Services.DatabaseUpdaterService;

interface

uses
{PROJECT}
  Shared.Inf.Contracts.Services.DatabaseUpdaterService,
  Shared.Inf.Database.Connection,
  Shared.Inf.Database.Context,
{SPRING}
  Spring.Container.Common;

type
  TDatabaseUpdaterService = class(TInterfacedObject, IDatabaseUpdaterService)
  private
    [Inject] FDb: TdamDb;
    [Inject] FDbContext: TDbContext;
    function IsPossibleExecute: Boolean;
    procedure OnExecute(const ACommands: TDatabaseUpdateCommands);
    procedure RunMigrations;
    procedure RunSeeds;
  public
    procedure Execute(const ACommands: TDatabaseUpdateCommands);
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.DatabaseConfig,
  cbsSystem.Contracts.Database.Seeders.DatabaseSeeder,
  cbsSystem.Support.Container;

{ TDatabaseUpdaterService }

procedure TDatabaseUpdaterService.Execute(const ACommands: TDatabaseUpdateCommands);
begin
  if IsPossibleExecute then
  begin
    OnExecute(ACommands);
  end;
end;

function TDatabaseUpdaterService.IsPossibleExecute: Boolean;
begin
  Result := App.Make<IDatabaseConfig>.Exists;
end;

procedure TDatabaseUpdaterService.OnExecute(const ACommands: TDatabaseUpdateCommands);
begin
  if TDatabaseUpdateCommand.RunMigrations in ACommands then
    RunMigrations;
  if TDatabaseUpdateCommand.RunSeeds in ACommands then
    RunSeeds;
end;

procedure TDatabaseUpdaterService.RunMigrations;
begin
  FDb.Connection.StartTransaction;
  try
    FDbContext.Connection := FDb.Connection;
    FDbContext.UpdateDatabase;
    FDb.Connection.Commit;
  except
    on E: Exception do
    begin
      FDb.Connection.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TDatabaseUpdaterService.RunSeeds;
begin
  FDb.Connection.StartTransaction;
  try
    for var LSeeder in App.MakeAll<IDatabaseSeeder> do
    begin
      LSeeder.Run;
    end;
    FDb.Connection.Commit;
  except
    on E: Exception do
    begin
      FDb.Connection.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.

