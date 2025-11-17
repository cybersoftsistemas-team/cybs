unit cbsMigrations.Migrations.Operations.DropIndexOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropIndexOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TDropIndexOperation = class(TNamedMigrationObjectOperation, IDropIndexOperation);

implementation

end.
