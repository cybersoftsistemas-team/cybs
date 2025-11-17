unit cbsMigrations.Migrations.Operations.CustomNumberColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.CustomNumberColumnOperation,
  cbsMigrations.Migrations.Operations.ColumnOperation;

type
  TCustomNumberColumnOperation = class(TColumnOperation, ICustomNumberColumnOperation)
  public
    function HasColumnType(const AColumnType: string): ICustomNumberColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): ICustomNumberColumnOperation;
    function HasSchema(const ASchema: string): ICustomNumberColumnOperation;
    function HasTable(const ATable: string): ICustomNumberColumnOperation;
    function IsOptional: ICustomNumberColumnOperation;
    function IsRequired: ICustomNumberColumnOperation;
  end;

implementation

{ TCustomNumberColumnOperation }

function TCustomNumberColumnOperation.HasColumnType(const AColumnType: string): ICustomNumberColumnOperation;
begin
  Result := TCustomNumberColumnOperation(inherited HasColumnType(AColumnType));
end;

function TCustomNumberColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): ICustomNumberColumnOperation;
begin
  Result := TCustomNumberColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TCustomNumberColumnOperation.HasSchema(const ASchema: string): ICustomNumberColumnOperation;
begin
  Result := TCustomNumberColumnOperation(inherited HasSchema(ASchema));
end;

function TCustomNumberColumnOperation.HasTable(const ATable: string): ICustomNumberColumnOperation;
begin
  Result := TCustomNumberColumnOperation(inherited HasTable(ATable));
end;

function TCustomNumberColumnOperation.IsOptional: ICustomNumberColumnOperation;
begin
  Result := TCustomNumberColumnOperation(inherited IsOptional);
end;

function TCustomNumberColumnOperation.IsRequired: ICustomNumberColumnOperation;
begin
  Result := TCustomNumberColumnOperation(inherited IsRequired);
end;

end.
