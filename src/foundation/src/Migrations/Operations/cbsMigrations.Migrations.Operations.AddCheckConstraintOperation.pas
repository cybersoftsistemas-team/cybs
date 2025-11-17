unit cbsMigrations.Migrations.Operations.AddCheckConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddCheckConstraintOperation,
  cbsMigrations.Migrations.Operations.CheckConstraintOperation;

type
  TAddCheckConstraintOperation = class(TCheckConstraintOperation, IAddCheckConstraintOperation)
  public
    function HasSchema(const ASchema: string): IAddCheckConstraintOperation;
    function HasTable(const ATable: string): IAddCheckConstraintOperation;
  end;

implementation

{ TAddCheckConstraintOperation }

function TAddCheckConstraintOperation.HasSchema(const ASchema: string): IAddCheckConstraintOperation;
begin
  Result := TAddCheckConstraintOperation(inherited HasSchema(ASchema));
end;

function TAddCheckConstraintOperation.HasTable(const ATable: string): IAddCheckConstraintOperation;
begin
  Result := TAddCheckConstraintOperation(inherited HasTable(ATable));
end;

end.
