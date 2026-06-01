unit cbsMigrations.Migrations.Operations.DecimalColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.DecimalColumnOperation,
  cbsMigrations.Migrations.Operations.NumberColumnOperation;

type
  TDecimalColumnOperation = class(TNumberColumnOperation, IDecimalColumnOperation)
  private
    FScale: Integer;
    function GetScale: Integer;
  public
    function HasColumnType(const AColumnType: string): IDecimalColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IDecimalColumnOperation;
    function HasPrecision(const APrecision, AScale: Integer): IDecimalColumnOperation;
    function HasSchema(const ASchema: string): IDecimalColumnOperation;
    function HasTable(const ATable: string): IDecimalColumnOperation;
    function IsOptional: IDecimalColumnOperation;
    function IsRequired: IDecimalColumnOperation;
    property Scale: Integer read GetScale;
  end;

implementation

{ TDecimalColumnOperation }

function TDecimalColumnOperation.GetScale: Integer;
begin
  Result := FScale;
end;

function TDecimalColumnOperation.HasColumnType(const AColumnType: string): IDecimalColumnOperation;
begin
  Result := TDecimalColumnOperation(inherited HasColumnType(AColumnType));
end;

function TDecimalColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IDecimalColumnOperation;
begin
  Result := TDecimalColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TDecimalColumnOperation.HasPrecision(const APrecision, AScale: Integer): IDecimalColumnOperation;
begin
  FScale := AScale;
  Result := TDecimalColumnOperation(inherited HasPrecision(APrecision));
end;

function TDecimalColumnOperation.HasSchema(const ASchema: string): IDecimalColumnOperation;
begin
  Result := TDecimalColumnOperation(inherited HasSchema(ASchema));
end;

function TDecimalColumnOperation.HasTable(const ATable: string): IDecimalColumnOperation;
begin
  Result := TDecimalColumnOperation(inherited HasTable(ATable));
end;

function TDecimalColumnOperation.IsOptional: IDecimalColumnOperation;
begin
  Result := TDecimalColumnOperation(inherited IsOptional);
end;

function TDecimalColumnOperation.IsRequired: IDecimalColumnOperation;
begin
 Result := TDecimalColumnOperation(inherited IsRequired);
end;

end.
