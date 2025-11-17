unit cbsMigrations.Migrations.Operations.AlterColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AlterColumnOperation,
  cbsMigrations.Migrations.Operations.ColumnOperation;

type
  TAlterColumnOperation = class(TColumnOperation, IAlterColumnOperation)
  private
    FCollation: string;
    function GetCollation: string;
  public
    function HasCollation(const ACollation: string): IAlterColumnOperation;
    function HasColumnType(const AColumnType: string): IAlterColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IAlterColumnOperation;
    function HasSchema(const ASchema: string): IAlterColumnOperation;
    function HasTable(const ATable: string): IAlterColumnOperation;
    function IsOptional: IAlterColumnOperation;
    function IsRequired: IAlterColumnOperation;
    property Collation: string read GetCollation;
  end;

implementation

{ TAlterColumnOperation }

function TAlterColumnOperation.GetCollation: string;
begin
  Result := FCollation;
end;

function TAlterColumnOperation.HasCollation(const ACollation: string): IAlterColumnOperation;
begin
  FCollation := ACollation;
  Result := Self;
end;

function TAlterColumnOperation.HasColumnType(const AColumnType: string): IAlterColumnOperation;
begin
  Result := TAlterColumnOperation(inherited HasColumnType(AColumnType));
end;

function TAlterColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IAlterColumnOperation;
begin
  Result := TAlterColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TAlterColumnOperation.HasSchema(const ASchema: string): IAlterColumnOperation;
begin
  Result := TAlterColumnOperation(inherited HasSchema(ASchema));
end;

function TAlterColumnOperation.HasTable(const ATable: string): IAlterColumnOperation;
begin
  Result := TAlterColumnOperation(inherited HasTable(ATable));
end;

function TAlterColumnOperation.IsOptional: IAlterColumnOperation;
begin
  Result := TAlterColumnOperation(inherited IsOptional);
end;

function TAlterColumnOperation.IsRequired: IAlterColumnOperation;
begin
  Result := TAlterColumnOperation(inherited IsRequired);
end;

end.
