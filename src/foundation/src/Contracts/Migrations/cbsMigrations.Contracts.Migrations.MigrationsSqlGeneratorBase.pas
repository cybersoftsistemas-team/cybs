unit cbsMigrations.Contracts.Migrations.MigrationsSqlGeneratorBase;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation,
{SPRING}
  Spring.Collections;

type
  IMigrationOperations = IEnumerable<IMigrationOperation>;

  IMigrationsSqlGeneratorBase = interface(IUnknown)
    ['{0A6DBF82-A713-4E58-BE14-7F30F0F6750B}']
    function Generate(const AOperations: IMigrationOperations): IMigrationCommands;
  end;

implementation

end.
