unit cbsMigrations.Migrations.Operations.AddBooleanColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddBooleanColumnOperation,
  cbsMigrations.Migrations.Operations.BooleanColumnOperation;

type
  TAddBooleanColumnOperation = class(TBooleanColumnOperation, IAddBooleanColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddBooleanColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddBooleanColumnOperation;
    function HasSchema(const ASchema: string): IAddBooleanColumnOperation;
    function HasTable(const ATable: string): IAddBooleanColumnOperation;
    function IsOptional: IAddBooleanColumnOperation;
    function IsRequired: IAddBooleanColumnOperation;
  end;

implementation

{ TAddBooleanColumnOperation }

function TAddBooleanColumnOperation.HasColumnType(const AColumnType: string): IAddBooleanColumnOperation;
begin
  Result := TAddBooleanColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddBooleanColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAddBooleanColumnOperation;
begin
  Result := TAddBooleanColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAddBooleanColumnOperation.HasSchema(const ASchema: string): IAddBooleanColumnOperation;
begin
  Result := TAddBooleanColumnOperation(inherited HasSchema(ASchema));
end;

function TAddBooleanColumnOperation.HasTable(const ATable: string): IAddBooleanColumnOperation;
begin
  Result := TAddBooleanColumnOperation(inherited HasTable(ATable));
end;

function TAddBooleanColumnOperation.IsOptional: IAddBooleanColumnOperation;
begin
  Result := TAddBooleanColumnOperation(inherited IsOptional);
end;

function TAddBooleanColumnOperation.IsRequired: IAddBooleanColumnOperation;
begin
  Result := TAddBooleanColumnOperation(inherited IsRequired);
end;

end.
