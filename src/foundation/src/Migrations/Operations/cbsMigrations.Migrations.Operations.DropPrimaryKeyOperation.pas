unit cbsMigrations.Migrations.Operations.DropPrimaryKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropPrimaryKeyOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TDropPrimaryKeyOperation = class(TNamedMigrationObjectOperation, IDropPrimaryKeyOperation);

implementation

end.
