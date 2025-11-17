unit cbsMigrations.Migrations.Operations.AddUniqueConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddUniqueConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.UniqueConstraintOperation;

type
  TAddUniqueConstraintOperation = class(TUniqueConstraintOperation, IAddUniqueConstraintOperation)
  public
    function HasColumns(const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation;
    function HasSchema(const ASchema: string): IAddUniqueConstraintOperation;
    function HasTable(const ATable: string): IAddUniqueConstraintOperation;
  end;

implementation

{ TAddUniqueConstraintOperation }

function TAddUniqueConstraintOperation.HasColumns(const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation;
begin
  Result := TAddUniqueConstraintOperation(inherited HasColumns(AColumns));
end;

function TAddUniqueConstraintOperation.HasSchema(const ASchema: string): IAddUniqueConstraintOperation;
begin
  Result := TAddUniqueConstraintOperation(inherited HasSchema(ASchema));
end;

function TAddUniqueConstraintOperation.HasTable(const ATable: string): IAddUniqueConstraintOperation;
begin
  Result := TAddUniqueConstraintOperation(inherited HasTable(ATable));
end;

end.
