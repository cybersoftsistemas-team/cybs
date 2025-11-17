unit cbsMigrations.Migrations.Operations.DropForeignKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DropForeignKeyOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TDropForeignKeyOperation = class(TNamedMigrationObjectOperation, IDropForeignKeyOperation);

implementation

end.
