unit cbsMigrations.Migrations.Operations.CustomStringColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomStringColumnOperation,
  cbsMigrations.Migrations.Operations.ColumnOperation;

type
  TCustomStringColumnOperation = class(TColumnOperation, ICustomStringColumnOperation)
  public
    function HasColumnType(const AColumnType: string): ICustomStringColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): ICustomStringColumnOperation;
    function HasSchema(const ASchema: string): ICustomStringColumnOperation;
    function HasTable(const ATable: string): ICustomStringColumnOperation;
    function IsOptional: ICustomStringColumnOperation;
    function IsRequired: ICustomStringColumnOperation;
  end;

implementation

{ TCustomStringColumnOperation }

function TCustomStringColumnOperation.HasColumnType(const AColumnType: string): ICustomStringColumnOperation;
begin
  Result := TCustomStringColumnOperation(inherited HasColumnType(AColumnType));
end;

function TCustomStringColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): ICustomStringColumnOperation;
begin
  Result := TCustomStringColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TCustomStringColumnOperation.HasSchema(const ASchema: string): ICustomStringColumnOperation;
begin
  Result := TCustomStringColumnOperation(inherited HasSchema(ASchema));
end;

function TCustomStringColumnOperation.HasTable(const ATable: string): ICustomStringColumnOperation;
begin
  Result := TCustomStringColumnOperation(inherited HasTable(ATable));
end;

function TCustomStringColumnOperation.IsOptional: ICustomStringColumnOperation;
begin
  Result := TCustomStringColumnOperation(inherited IsOptional);
end;

function TCustomStringColumnOperation.IsRequired: ICustomStringColumnOperation;
begin
  Result := TCustomStringColumnOperation(inherited IsRequired);
end;

end.
