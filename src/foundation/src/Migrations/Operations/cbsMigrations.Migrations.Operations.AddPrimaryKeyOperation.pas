unit cbsMigrations.Migrations.Operations.AddPrimaryKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddPrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.PrimaryKeyOperation,
  cbsMigrations.Migrations.Operations.PrimaryKeyOperation;

type
  TAddPrimaryKeyOperation = class(TPrimaryKeyOperation, IAddPrimaryKeyOperation)
  public
    function HasColumns(const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation;
    function HasSchema(const ASchema: string): IAddPrimaryKeyOperation;
    function HasTable(const ATable: string): IAddPrimaryKeyOperation;
  end;

implementation

{ TAddPrimaryKeyOperation }

function TAddPrimaryKeyOperation.HasColumns(const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation;
begin
  Result := TAddPrimaryKeyOperation(inherited HasColumns(AColumns));
end;

function TAddPrimaryKeyOperation.HasSchema(const ASchema: string): IAddPrimaryKeyOperation;
begin
  Result := TAddPrimaryKeyOperation(inherited HasSchema(ASchema));
end;

function TAddPrimaryKeyOperation.HasTable(const ATable: string): IAddPrimaryKeyOperation;
begin
  Result := TAddPrimaryKeyOperation(inherited HasTable(ATable));
end;

end.
