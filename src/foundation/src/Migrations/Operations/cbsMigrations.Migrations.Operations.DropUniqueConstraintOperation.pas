unit cbsMigrations.Migrations.Operations.DropUniqueConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropUniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TDropUniqueConstraintOperation = class(TNamedMigrationObjectOperation, IDropUniqueConstraintOperation);

implementation

end.
