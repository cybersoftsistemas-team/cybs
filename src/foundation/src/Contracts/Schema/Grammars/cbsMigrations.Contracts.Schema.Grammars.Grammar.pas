unit cbsMigrations.Contracts.Schema.Grammars.Grammar;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommand,
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
  cbsMigrations.Schema.Types;

type
  IGrammar = interface(IUnknown)
    ['{CAA63EE1-CC33-4A56-A9BF-FC3AF6A7D240}']
    function CompileCreateRepository(const ADriverID: DriverID; const ATable: string): IMigrationCommands;
    function CompileGetRan(const ASchema, ATable: string): IMigrationCommand;
    function CompileGetLastBatchNumber(const ASchema, ATable: string): IMigrationCommand;
    function CompileRunPending(const ADriverID: DriverID; const AMigrationTypes: TArray<TClass>; const ABatch: Integer; const ATable: string): IMigrationCommands;
    function CompileTableExists(const ASchema, ATable: string): IMigrationCommand;
  end;

implementation

end.
