unit cbsMigrations.Migrations.Operations.ConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TConstraintOperation = class(TNamedMigrationObjectOperation, IConstraintOperation)
  public
    function HasSchema(const ASchema: string): IConstraintOperation;
    function HasTable(const ATable: string): IConstraintOperation;
  end;

implementation

{ TConstraintOperation }

function TConstraintOperation.HasSchema(const ASchema: string): IConstraintOperation;
begin
  SetSchema(ASchema);
  Result := Self;
end;

function TConstraintOperation.HasTable(const ATable: string): IConstraintOperation;
begin
  SetTable(ATable);
  Result := Self;
end;

end.
