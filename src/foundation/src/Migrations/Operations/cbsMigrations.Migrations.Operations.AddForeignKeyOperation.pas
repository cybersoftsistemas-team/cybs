unit cbsMigrations.Migrations.Operations.AddForeignKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation,
  cbsMigrations.Migrations.Operations.ForeignKeyOperation;

type
  TAddForeignKeyOperation = class(TForeignKeyOperation, IAddForeignKeyOperation)
  public
    function HasColumns(const AColumns: array of TForeignKeyColumn): IAddForeignKeyOperation;
    function HasOnDelete(const Action: ReferentialAction): IAddForeignKeyOperation;
    function HasOnUpdate(const Action: ReferentialAction): IAddForeignKeyOperation;
    function HasPrincipalColumns(const AColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
    function HasPrincipalSchema(const ASchema: string): IAddForeignKeyOperation;
    function HasPrincipalTable(const ATable: string): IAddForeignKeyOperation;
    function HasSchema(const ASchema: string): IAddForeignKeyOperation;
    function HasTable(const ATable: string): IAddForeignKeyOperation;
  end;

implementation

{ TAddForeignKeyOperation }

function TAddForeignKeyOperation.HasColumns(const AColumns: array of TForeignKeyColumn): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation(inherited HasColumns(AColumns));
end;

function TAddForeignKeyOperation.HasOnDelete(const Action: ReferentialAction): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation(inherited HasOnDelete(Action));
end;

function TAddForeignKeyOperation.HasOnUpdate(const Action: ReferentialAction): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation(inherited HasOnUpdate(Action));
end;

function TAddForeignKeyOperation.HasPrincipalColumns(
  const AColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation(inherited HasPrincipalColumns(AColumns));
end;

function TAddForeignKeyOperation.HasPrincipalSchema(const ASchema: string): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation(inherited HasPrincipalSchema(ASchema));
end;

function TAddForeignKeyOperation.HasPrincipalTable(const ATable: string): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation(inherited HasPrincipalTable(ATable));
end;

function TAddForeignKeyOperation.HasSchema(const ASchema: string): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation(inherited HasSchema(ASchema));
end;

function TAddForeignKeyOperation.HasTable(const ATable: string): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation(inherited HasTable(ATable));
end;

end.
