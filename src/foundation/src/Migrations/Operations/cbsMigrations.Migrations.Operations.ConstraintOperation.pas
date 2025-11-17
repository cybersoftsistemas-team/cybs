unit cbsMigrations.Migrations.Operations.ConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TConstraintOperation = class(TNamedMigrationObjectOperation, IConstraintOperation)
  public
    constructor Create(const AName: string);
    function HasSchema(const ASchema: string): IConstraintOperation;
    function HasTable(const ATable: string): IConstraintOperation;
  end;

implementation

{ TConstraintOperation }

constructor TConstraintOperation.Create(const AName: string);
begin
  inherited Create(AName);
end;

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
