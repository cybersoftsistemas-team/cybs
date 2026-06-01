unit cbsMigrations.Migrations.Operations.AddDecimalColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddDecimalColumnOperation,
  cbsMigrations.Migrations.Operations.DecimalColumnOperation;

type
  TAddDecimalColumnOperation = class(TDecimalColumnOperation, IAddDecimalColumnOperation)
  public
    function HasColumnType(const AColumnType: string): IAddDecimalColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAddDecimalColumnOperation;
    function HasPrecision(const APrecision, AScale: Integer): IAddDecimalColumnOperation;
    function HasSchema(const ASchema: string): IAddDecimalColumnOperation;
    function HasTable(const ATable: string): IAddDecimalColumnOperation;
    function IsOptional: IAddDecimalColumnOperation;
    function IsRequired: IAddDecimalColumnOperation;
  end;

implementation

{ TAddDecimalColumnOperation }

function TAddDecimalColumnOperation.HasColumnType(const AColumnType: string): IAddDecimalColumnOperation;
begin
  Result := TAddDecimalColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAddDecimalColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAddDecimalColumnOperation;
begin
  Result := TAddDecimalColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAddDecimalColumnOperation.HasPrecision(const APrecision, AScale: Integer): IAddDecimalColumnOperation;
begin
  Result := TAddDecimalColumnOperation(inherited HasPrecision(APrecision, AScale));
end;

function TAddDecimalColumnOperation.HasSchema(const ASchema: string): IAddDecimalColumnOperation;
begin
  Result := TAddDecimalColumnOperation(inherited HasSchema(ASchema));
end;

function TAddDecimalColumnOperation.HasTable(const ATable: string): IAddDecimalColumnOperation;
begin
  Result := TAddDecimalColumnOperation(inherited HasTable(ATable));
end;

function TAddDecimalColumnOperation.IsOptional: IAddDecimalColumnOperation;
begin
  Result := TAddDecimalColumnOperation(inherited IsOptional);
end;

function TAddDecimalColumnOperation.IsRequired: IAddDecimalColumnOperation;
begin
  Result := TAddDecimalColumnOperation(inherited IsRequired);
end;

end.
