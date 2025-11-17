unit cbsMigrations.Contracts.Migrations.MigrationCommandExecutor;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder;

type
  IMigrationCommandExecutor = interface(IUnknown)
    ['{E6CDCAD9-EA02-46A2-8458-623312F636A2}']
    procedure ExecuteNonQuery(const AMigrationCommands: IMigrationCommands);
  end;

implementation

end.
