unit cbsMigrations.Migrations.Operations.AddDefaultConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddDefaultConstraintOperation,
  cbsMigrations.Migrations.Operations.DefaultConstraintOperation;

type
  TAddDefaultConstraintOperation = class(TDefaultConstraintOperation, IAddDefaultConstraintOperation)
  public
    function HasSchema(const ASchema: string): IAddDefaultConstraintOperation;
    function HasTable(const ATable: string): IAddDefaultConstraintOperation;
  end;

implementation

{ TAddDefaultConstraintOperation }

function TAddDefaultConstraintOperation.HasSchema(const ASchema: string): IAddDefaultConstraintOperation;
begin
  Result := TAddDefaultConstraintOperation(inherited HasSchema(ASchema));
end;

function TAddDefaultConstraintOperation.HasTable(const ATable: string): IAddDefaultConstraintOperation;
begin
  Result := TAddDefaultConstraintOperation(inherited HasTable(ATable));
end;

end.
