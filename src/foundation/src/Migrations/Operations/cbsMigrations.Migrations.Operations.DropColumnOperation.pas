unit cbsMigrations.Migrations.Operations.DropColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropColumnOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TDropColumnOperation = class(TNamedMigrationObjectOperation, IDropColumnOperation);

implementation

end.
