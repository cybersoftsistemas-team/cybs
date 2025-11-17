unit cbsMigrations.Migrations.Operations.DateTimeColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DateTimeColumnOperation,
  cbsMigrations.Migrations.Operations.CustomNumberColumnOperation;

type
  TDateTimeColumnOperation = class(TCustomNumberColumnOperation, IDateTimeColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IDateTimeColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IDateTimeColumnOperation;
    function HasSchema(const ASchema: string): IDateTimeColumnOperation;
    function HasTable(const ATable: string): IDateTimeColumnOperation;
    function IsOptional: IDateTimeColumnOperation;
    function IsRequired: IDateTimeColumnOperation;
  end;

implementation

{ TDateTimeColumnOperation }

function TDateTimeColumnOperation.HasColumnType(const AColumnType: string): IDateTimeColumnOperation;
begin
  Result := TDateTimeColumnOperation(inherited HasColumnType(AColumnType));
end;

function TDateTimeColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IDateTimeColumnOperation;
begin
  Result := TDateTimeColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TDateTimeColumnOperation.HasSchema(const ASchema: string): IDateTimeColumnOperation;
begin
  Result := TDateTimeColumnOperation(inherited HasSchema(ASchema));
end;

function TDateTimeColumnOperation.HasTable(const ATable: string): IDateTimeColumnOperation;
begin
  Result := TDateTimeColumnOperation(inherited HasTable(ATable));
end;

function TDateTimeColumnOperation.IsOptional: IDateTimeColumnOperation;
begin
  Result := TDateTimeColumnOperation(inherited IsOptional);
end;

function TDateTimeColumnOperation.IsRequired: IDateTimeColumnOperation;
begin
 Result := TDateTimeColumnOperation(inherited IsRequired);
end;

end.
