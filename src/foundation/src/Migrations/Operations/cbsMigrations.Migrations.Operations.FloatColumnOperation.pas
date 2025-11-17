unit cbsMigrations.Migrations.Operations.FloatColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.FloatColumnOperation,
  cbsMigrations.Migrations.Operations.NumberColumnOperation;

type
  TFloatColumnOperation = class(TNumberColumnOperation, IFloatColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IFloatColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IFloatColumnOperation;
    function HasPrecision(const APrecision: Integer): IFloatColumnOperation;
    function HasSchema(const ASchema: string): IFloatColumnOperation;
    function HasTable(const ATable: string): IFloatColumnOperation;
    function IsOptional: IFloatColumnOperation;
    function IsRequired: IFloatColumnOperation;
  end;

implementation

{ TFloatColumnOperation }

function TFloatColumnOperation.HasColumnType(const AColumnType: string): IFloatColumnOperation;
begin
  Result := TFloatColumnOperation(inherited HasColumnType(AColumnType));
end;

function TFloatColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IFloatColumnOperation;
begin
  Result := TFloatColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TFloatColumnOperation.HasPrecision(const APrecision: Integer): IFloatColumnOperation;
begin
  Result := TFloatColumnOperation(inherited HasPrecision(APrecision));
end;

function TFloatColumnOperation.HasSchema(const ASchema: string): IFloatColumnOperation;
begin
  Result := TFloatColumnOperation(inherited HasSchema(ASchema));
end;

function TFloatColumnOperation.HasTable(const ATable: string): IFloatColumnOperation;
begin
  Result := TFloatColumnOperation(inherited HasTable(ATable));
end;

function TFloatColumnOperation.IsOptional: IFloatColumnOperation;
begin
  Result := TFloatColumnOperation(inherited IsOptional);
end;

function TFloatColumnOperation.IsRequired: IFloatColumnOperation;
begin
 Result := TFloatColumnOperation(inherited IsRequired);
end;

end.
