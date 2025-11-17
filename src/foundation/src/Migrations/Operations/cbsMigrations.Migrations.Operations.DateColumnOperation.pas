unit cbsMigrations.Migrations.Operations.DateColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DateColumnOperation,
  cbsMigrations.Migrations.Operations.CustomNumberColumnOperation;

type
  TDateColumnOperation = class(TCustomNumberColumnOperation, IDateColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IDateColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IDateColumnOperation;
    function HasSchema(const ASchema: string): IDateColumnOperation;
    function HasTable(const ATable: string): IDateColumnOperation;
    function IsOptional: IDateColumnOperation;
    function IsRequired: IDateColumnOperation;
  end;

implementation

{ TDateColumnOperation }

function TDateColumnOperation.HasColumnType(const AColumnType: string): IDateColumnOperation;
begin
  Result := TDateColumnOperation(inherited HasColumnType(AColumnType));
end;

function TDateColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IDateColumnOperation;
begin
  Result := TDateColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TDateColumnOperation.HasSchema(const ASchema: string): IDateColumnOperation;
begin
  Result := TDateColumnOperation(inherited HasSchema(ASchema));
end;

function TDateColumnOperation.HasTable(const ATable: string): IDateColumnOperation;
begin
  Result := TDateColumnOperation(inherited HasTable(ATable));
end;

function TDateColumnOperation.IsOptional: IDateColumnOperation;
begin
  Result := TDateColumnOperation(inherited IsOptional);
end;

function TDateColumnOperation.IsRequired: IDateColumnOperation;
begin
 Result := TDateColumnOperation(inherited IsRequired);
end;

end.
