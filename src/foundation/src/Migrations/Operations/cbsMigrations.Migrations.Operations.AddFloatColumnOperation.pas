unit cbsMigrations.Migrations.Operations.AddFloatColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddFloatColumnOperation,
  cbsMigrations.Migrations.Operations.FloatColumnOperation;

type
  TAddFloatColumnOperation = class(TFloatColumnOperation, IAddFloatColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddFloatColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddFloatColumnOperation;
    function HasPrecision(const APrecision: Integer): IAddFloatColumnOperation;
    function HasSchema(const ASchema: string): IAddFloatColumnOperation;
    function HasTable(const ATable: string): IAddFloatColumnOperation;
    function IsOptional: IAddFloatColumnOperation;
    function IsRequired: IAddFloatColumnOperation;
  end;

implementation

{ TAddFloatColumnOperation }

function TAddFloatColumnOperation.HasColumnType(const AColumnType: string): IAddFloatColumnOperation;
begin
  Result := TAddFloatColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddFloatColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAddFloatColumnOperation;
begin
  Result := TAddFloatColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAddFloatColumnOperation.HasPrecision(const APrecision: Integer): IAddFloatColumnOperation;
begin
  Result := TAddFloatColumnOperation(inherited HasPrecision(APrecision));
end;

function TAddFloatColumnOperation.HasSchema(const ASchema: string): IAddFloatColumnOperation;
begin
  Result := TAddFloatColumnOperation(inherited HasSchema(ASchema));
end;

function TAddFloatColumnOperation.HasTable(const ATable: string): IAddFloatColumnOperation;
begin
  Result := TAddFloatColumnOperation(inherited HasTable(ATable));
end;

function TAddFloatColumnOperation.IsOptional: IAddFloatColumnOperation;
begin
  Result := TAddFloatColumnOperation(inherited IsOptional);
end;

function TAddFloatColumnOperation.IsRequired: IAddFloatColumnOperation;
begin
  Result := TAddFloatColumnOperation(inherited IsRequired);
end;

end.
