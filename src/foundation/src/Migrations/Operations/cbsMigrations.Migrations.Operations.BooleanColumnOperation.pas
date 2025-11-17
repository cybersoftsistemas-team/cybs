unit cbsMigrations.Migrations.Operations.BooleanColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.BooleanColumnOperation,
  cbsMigrations.Migrations.Operations.CustomNumberColumnOperation;

type
  TBooleanColumnOperation = class(TCustomNumberColumnOperation, IBooleanColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IBooleanColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IBooleanColumnOperation;
    function HasSchema(const ASchema: string): IBooleanColumnOperation;
    function HasTable(const ATable: string): IBooleanColumnOperation;
    function IsOptional: IBooleanColumnOperation;
    function IsRequired: IBooleanColumnOperation;
  end;

implementation

{ TBooleanColumnOperation }

function TBooleanColumnOperation.HasColumnType(const AColumnType: string): IBooleanColumnOperation;
begin
  Result := TBooleanColumnOperation(inherited HasColumnType(AColumnType));
end;

function TBooleanColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IBooleanColumnOperation;
begin
  Result := TBooleanColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TBooleanColumnOperation.HasSchema(const ASchema: string): IBooleanColumnOperation;
begin
  Result := TBooleanColumnOperation(inherited HasSchema(ASchema));
end;

function TBooleanColumnOperation.HasTable(const ATable: string): IBooleanColumnOperation;
begin
  Result := TBooleanColumnOperation(inherited HasTable(ATable));
end;

function TBooleanColumnOperation.IsOptional: IBooleanColumnOperation;
begin
  Result := TBooleanColumnOperation(inherited IsOptional);
end;

function TBooleanColumnOperation.IsRequired: IBooleanColumnOperation;
begin
  Result := TBooleanColumnOperation(inherited IsRequired);
end;

end.
