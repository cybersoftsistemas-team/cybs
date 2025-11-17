unit cbsMigrations.Migrations.Operations.LengthColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.LengthColumnOperation,
  cbsMigrations.Migrations.Operations.CustomStringColumnOperation;

type
  TLengthColumnOperation = class(TCustomStringColumnOperation, ILengthColumnOperation)
  private
    FLength: Integer;
    function GetLength: Integer;
  public
    function HasColumnType(const AColumnType: string): ILengthColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): ILengthColumnOperation;
    function HasMaxLength(const ALength: Integer): ILengthColumnOperation;
    function HasSchema(const ASchema: string): ILengthColumnOperation;
    function HasTable(const ATable: string): ILengthColumnOperation;
    function IsOptional: ILengthColumnOperation;
    function IsRequired: ILengthColumnOperation;
    property Length: Integer read GetLength;
  end;

implementation

{ TLengthColumnOperation }

function TLengthColumnOperation.GetLength: Integer;
begin
  Result := FLength;
end;

function TLengthColumnOperation.HasColumnType(const AColumnType: string): ILengthColumnOperation;
begin
  Result := TLengthColumnOperation(inherited HasColumnType(AColumnType));
end;

function TLengthColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): ILengthColumnOperation;
begin
  Result := TLengthColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TLengthColumnOperation.HasMaxLength(const ALength: Integer): ILengthColumnOperation;
begin
  FLength := ALength;
  Result := Self;
end;

function TLengthColumnOperation.HasSchema(const ASchema: string): ILengthColumnOperation;
begin
  Result := TLengthColumnOperation(inherited HasSchema(ASchema));
end;

function TLengthColumnOperation.HasTable(const ATable: string): ILengthColumnOperation;
begin
  Result := TLengthColumnOperation(inherited HasTable(ATable));
end;

function TLengthColumnOperation.IsOptional: ILengthColumnOperation;
begin
  Result := TLengthColumnOperation(inherited IsOptional);
end;

function TLengthColumnOperation.IsRequired: ILengthColumnOperation;
begin
  Result := TLengthColumnOperation(inherited IsRequired);
end;

end.
