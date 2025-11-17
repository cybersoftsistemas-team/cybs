unit cbsMigrations.Migrations.Operations.ColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TColumnOperation = class(TNamedMigrationObjectOperation, IColumnOperation)
  private
    FColumnType: string;
    FDefaultValueSql: string;
    FNullable: Boolean;
    function GetColumnType: string;
    function GetDefaultValueSql: string;
    function GetNullable: Boolean;
  protected
    procedure DoPrepare; override;
  public
    function HasColumnType(const AColumnType: string): IColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IColumnOperation;
    function HasSchema(const ASchema: string): IColumnOperation;
    function HasTable(const ATable: string): IColumnOperation;
    function IsOptional: IColumnOperation;
    function IsRequired: IColumnOperation;
    property ColumnType: string read GetColumnType;
    property DefaultValueSql: string read GetDefaultValueSql;
    property Nullable: Boolean read GetNullable;
  end;

  ColumnOperationType = class of TColumnOperation;

implementation

{ TColumnOperation }

function TColumnOperation.GetColumnType: string;
begin
  Result := FColumnType;
end;

function TColumnOperation.GetDefaultValueSql: string;
begin
  Result := FDefaultValueSql;
end;

function TColumnOperation.GetNullable: Boolean;
begin
  Result := FNullable;
end;

function TColumnOperation.HasColumnType(const AColumnType: string): IColumnOperation;
begin
  FColumnType := AColumnType;
  Result := Self;
end;

function TColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IColumnOperation;
begin
  FDefaultValueSql := ADefaultValueSql;
  Result := Self;
end;

function TColumnOperation.HasSchema(const ASchema: string): IColumnOperation;
begin
  SetSchema(ASchema);
  Result := Self;
end;

function TColumnOperation.HasTable(const ATable: string): IColumnOperation;
begin
  SetTable(ATable);
  Result := Self;
end;

function TColumnOperation.IsOptional: IColumnOperation;
begin
  FNullable := True;
  Result := Self;
end;

function TColumnOperation.IsRequired: IColumnOperation;
begin
  FNullable := False;
  Result := Self;
end;

procedure TColumnOperation.DoPrepare;
begin
  // This method can be overwritten by inherited classes.
end;

end.
