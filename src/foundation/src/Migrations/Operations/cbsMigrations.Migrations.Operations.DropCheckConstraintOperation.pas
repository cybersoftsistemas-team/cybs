unit cbsMigrations.Migrations.Operations.DropCheckConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropCheckConstraintOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TDropCheckConstraintOperation = class(TNamedMigrationObjectOperation, IDropCheckConstraintOperation);

implementation

end.
