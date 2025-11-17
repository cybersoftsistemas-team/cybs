unit cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.NamedMigrationObjectOperation;

type
  IConstraintOperation = interface(INamedMigrationObjectOperation)
    ['{DA2E0AF6-7C73-4C78-BC9D-6269BB30928B}']
    function HasSchema(const ASchema: string): IConstraintOperation;
    function HasTable(const ATable: string): IConstraintOperation;
  end;

implementation

end.
