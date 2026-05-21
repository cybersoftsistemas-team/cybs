unit cbsMigrations.Migrations.Operations.AddDefaultConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddDefaultConstraintOperation,
  cbsMigrations.Migrations.Operations.DefaultConstraintOperation;

type
  TAddDefaultConstraintOperation = class(TDefaultConstraintOperation, IAddDefaultConstraintOperation)
  public
    function HasColumn(const AColumnName: TColumnName): IAddDefaultConstraintOperation;
    function HasSchema(const ASchema: string): IAddDefaultConstraintOperation;
    function HasTable(const ATable: string): IAddDefaultConstraintOperation;
    function HasValue(const AValue: string): IAddDefaultConstraintOperation;
  end;

implementation

{ TAddDefaultConstraintOperation }

function TAddDefaultConstraintOperation.HasColumn(const AColumnName: TColumnName): IAddDefaultConstraintOperation;
begin
  Result := TAddDefaultConstraintOperation(inherited HasColumn(AColumnName));
end;

function TAddDefaultConstraintOperation.HasSchema(const ASchema: string): IAddDefaultConstraintOperation;
begin
  Result := TAddDefaultConstraintOperation(inherited HasSchema(ASchema));
end;

function TAddDefaultConstraintOperation.HasTable(const ATable: string): IAddDefaultConstraintOperation;
begin
  Result := TAddDefaultConstraintOperation(inherited HasTable(ATable));
end;

function TAddDefaultConstraintOperation.HasValue(const AValue: string): IAddDefaultConstraintOperation;
begin
  Result := TAddDefaultConstraintOperation(inherited HasValue(AValue));
end;

end.
