unit Shared.Inf.Contracts.Services.DatabaseUpdaterService;

interface

uses
{PROJECT}
  cbsMigrations.Migrations.MigrationContext,
  cbsSystem.Infrastructure.BaseDbModule;

type
  TDatabaseUpdateCommand = (
    RunMigrations,
    RunSeeds
  );

  TDatabaseUpdateCommands = set of TDatabaseUpdateCommand;

  IDatabaseUpdaterService = interface(IUnknown)
    ['{0BF455DC-D39B-4A89-8F77-A6F9A30D3B44}']
    procedure Execute(const ACommands: TDatabaseUpdateCommands);
  end;

implementation

end.

