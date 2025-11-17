unit cbsMigrations.Migrations.Operations.AddDateColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddDateColumnOperation,
  cbsMigrations.Migrations.Operations.DateColumnOperation;

type
  TAddDateColumnOperation = class(TDateColumnOperation, IAddDateColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddDateColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddDateColumnOperation;
    function HasSchema(const ASchema: string): IAddDateColumnOperation;
    function HasTable(const ATable: string): IAddDateColumnOperation;
    function IsOptional: IAddDateColumnOperation;
    function IsRequired: IAddDateColumnOperation;
  end;

implementation

{ TAddDateColumnOperation }

function TAddDateColumnOperation.HasColumnType(const AColumnType: string): IAddDateColumnOperation;
begin
  Result := TAddDateColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddDateColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAddDateColumnOperation;
begin
  Result := TAddDateColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAddDateColumnOperation.HasSchema(const ASchema: string): IAddDateColumnOperation;
begin
  Result := TAddDateColumnOperation(inherited HasSchema(ASchema));
end;

function TAddDateColumnOperation.HasTable(const ATable: string): IAddDateColumnOperation;
begin
  Result := TAddDateColumnOperation(inherited HasTable(ATable));
end;

function TAddDateColumnOperation.IsOptional: IAddDateColumnOperation;
begin
  Result := TAddDateColumnOperation(inherited IsOptional);
end;

function TAddDateColumnOperation.IsRequired: IAddDateColumnOperation;
begin
  Result := TAddDateColumnOperation(inherited IsRequired);
end;

end.
