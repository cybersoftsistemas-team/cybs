unit cbsMigrations.Migrations.Operations.NumberColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.NumberColumnOperation,
  cbsMigrations.Migrations.Operations.CustomNumberColumnOperation;

type
  TNumberColumnOperation = class(TCustomNumberColumnOperation, INumberColumnOperation)
  private
    FPrecision: Integer;
    function GetPrecision: Integer;
  public
    constructor Create(const AName: string);
    function HasColumnType(const AColumnType: string): INumberColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): INumberColumnOperation;
    function HasPrecision(const APrecision: Integer): INumberColumnOperation;
    function HasSchema(const ASchema: string): INumberColumnOperation;
    function HasTable(const ATable: string): INumberColumnOperation;
    function IsOptional: INumberColumnOperation;
    function IsRequired: INumberColumnOperation;
    property Precision: Integer read GetPrecision;
  end;

implementation

{ TNumberColumnOperation }

constructor TNumberColumnOperation.Create(const AName: string);
begin
  inherited Create(AName);
  HasPrecision(0);
end;

function TNumberColumnOperation.GetPrecision: Integer;
begin
  Result := FPrecision;
end;

function TNumberColumnOperation.HasColumnType(const AColumnType: string): INumberColumnOperation;
begin
  Result := TNumberColumnOperation(inherited HasColumnType(AColumnType));
end;

function TNumberColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): INumberColumnOperation;
begin
  Result := TNumberColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TNumberColumnOperation.HasPrecision(const APrecision: Integer): INumberColumnOperation;
begin
  FPrecision := APrecision;
  Result := Self;
end;

function TNumberColumnOperation.HasSchema(const ASchema: string): INumberColumnOperation;
begin
  Result := TNumberColumnOperation(inherited HasSchema(ASchema));
end;

function TNumberColumnOperation.HasTable(const ATable: string): INumberColumnOperation;
begin
  Result := TNumberColumnOperation(inherited HasTable(ATable));
end;

function TNumberColumnOperation.IsOptional: INumberColumnOperation;
begin
  Result := TNumberColumnOperation(inherited IsOptional);
end;

function TNumberColumnOperation.IsRequired: INumberColumnOperation;
begin
  Result := TNumberColumnOperation(inherited IsRequired);
end;

end.
