unit cbsMigrations.Migrations.Operations.AddDateTimeColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddDateTimeColumnOperation,
  cbsMigrations.Migrations.Operations.DateTimeColumnOperation;

type
  TAddDateTimeColumnOperation = class(TDateTimeColumnOperation, IAddDateTimeColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddDateTimeColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddDateTimeColumnOperation;
    function HasSchema(const ASchema: string): IAddDateTimeColumnOperation;
    function HasTable(const ATable: string): IAddDateTimeColumnOperation;
    function IsOptional: IAddDateTimeColumnOperation;
    function IsRequired: IAddDateTimeColumnOperation;
  end;

implementation

{ TAddDateTimeColumnOperation }

function TAddDateTimeColumnOperation.HasColumnType(const AColumnType: string): IAddDateTimeColumnOperation;
begin
  Result := TAddDateTimeColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddDateTimeColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAddDateTimeColumnOperation;
begin
  Result := TAddDateTimeColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAddDateTimeColumnOperation.HasSchema(const ASchema: string): IAddDateTimeColumnOperation;
begin
  Result := TAddDateTimeColumnOperation(inherited HasSchema(ASchema));
end;

function TAddDateTimeColumnOperation.HasTable(const ATable: string): IAddDateTimeColumnOperation;
begin
  Result := TAddDateTimeColumnOperation(inherited HasTable(ATable));
end;

function TAddDateTimeColumnOperation.IsOptional: IAddDateTimeColumnOperation;
begin
  Result := TAddDateTimeColumnOperation(inherited IsOptional);
end;

function TAddDateTimeColumnOperation.IsRequired: IAddDateTimeColumnOperation;
begin
  Result := TAddDateTimeColumnOperation(inherited IsRequired);
end;

end.
