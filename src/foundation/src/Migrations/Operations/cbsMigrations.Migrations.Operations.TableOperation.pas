unit cbsMigrations.Migrations.Operations.TableOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.IndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.TableOperation,
  cbsMigrations.Migrations.Operations.MigrationObjectOperation;

type
  TTableOperation = class(TMigrationObjectOperation, ITableOperation)
  private
    FColumns: ITableColumnList;
    FConstraints: ITableConstraintList;
    FIndexes: ITableIndexList;
    procedure AddColumn(const AColumn: IColumnOperation);
    procedure AddConstraint(const AConstraint: IConstraintOperation);
    procedure AddIndex(const AIndex: IIndexOperation);
    procedure DefineSchemaAndTableForColumns;
    procedure DefineSchemaAndTableForConstraints;
    procedure DefineSchemaAndTableForDependencies;
    procedure DefineSchemaAndTableForIndexes;
    procedure PrepareColumns;
    procedure PrepareConstraints;
    procedure PrepareDependencies;
    procedure PrepareIndexes;
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const ATable: string);
    destructor Destroy; override;
    function Columns: ITableColumns; overload;
    function Columns(const AColumns: array of IColumnOperation): ITableOperation; overload;
    function Constraints: ITableConstraints; overload;
    function Constraints(const AConstraints: array of IConstraintOperation): ITableOperation; overload;
    function HasSchema(const ASchema: string): ITableOperation;
    function Indexes: ITableIndexes; overload;
    function Indexes(const AIndexes: array of IIndexOperation): ITableOperation; overload;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TTableOperation }

constructor TTableOperation.Create(const ATable: string);
begin
  inherited Create;
  FColumns := CreateTableColumnList;
  FConstraints := CreateTableConstraintList;
  FIndexes := CreateTableIndexList;
  SetTable(ATable);
end;

destructor TTableOperation.Destroy;
begin
  FColumns.Clear;
  FConstraints.Clear;
  FIndexes.Clear;
  FColumns := nil;
  FConstraints := nil;
  FIndexes := nil;
  inherited;
end;

function TTableOperation.Columns: ITableColumns;
begin
  Result := FColumns;
end;

function TTableOperation.Columns(const AColumns: array of IColumnOperation): ITableOperation;
begin
  for var LColumn in AColumns do
  begin
    AddColumn(LColumn);
  end;
  Result := Self;
end;

function TTableOperation.Constraints(const AConstraints: array of IConstraintOperation): ITableOperation;
begin
  for var LConstraint in AConstraints do
  begin
    AddConstraint(LConstraint);
  end;
  Result := Self;
end;

function TTableOperation.Constraints: ITableConstraints;
begin
  Result := FConstraints;
end;

function TTableOperation.HasSchema(const ASchema: string): ITableOperation;
begin
  SetSchema(ASchema);
  Result := Self;
end;

function TTableOperation.Indexes(const AIndexes: array of IIndexOperation): ITableOperation;
begin
  for var LIndex in AIndexes do
  begin
    AddIndex(LIndex);
  end;
  Result := Self;
end;

function TTableOperation.Indexes: ITableIndexes;
begin
  Result := FIndexes;
end;

procedure TTableOperation.AddColumn(const AColumn: IColumnOperation);
begin
  if not FColumns.Contains(AColumn,
    function(const ALeft, ARight: IColumnOperation): Boolean
    begin
      Result := SameText(ALeft.Name, ARight.Name);
    end) then
  begin
    FColumns.Add(
      AColumn.HasSchema(Schema)
        .HasTable(Table));
  end;
end;

procedure TTableOperation.AddConstraint(const AConstraint: IConstraintOperation);
begin
  FConstraints.Add(
    AConstraint.HasSchema(Schema)
     .HasTable(Table));
end;

procedure TTableOperation.AddIndex(const AIndex: IIndexOperation);
begin
  FIndexes.Add(
    AIndex.HasSchema(Schema)
     .HasTable(Table));
end;

procedure TTableOperation.DoPrepare;
begin
  DefineSchemaAndTableForDependencies;
  PrepareDependencies;
end;

procedure TTableOperation.DefineSchemaAndTableForColumns;
begin
  FColumns.ForEach(
    procedure(const AColumn: IColumnOperation)
    begin
      if AColumn.Table.Trim.IsEmpty then
      begin
        AColumn.HasTable(Table);
      end;
      if AColumn.Schema.Trim.IsEmpty then
      begin
        AColumn.HasSchema(Schema);
      end;
    end);
end;

procedure TTableOperation.DefineSchemaAndTableForConstraints;
begin
  FConstraints.ForEach(
    procedure(const AConstraint: IConstraintOperation)
    begin
      if AConstraint.Table.Trim.IsEmpty then
      begin
        AConstraint.HasTable(Table);
      end;
      if AConstraint.Schema.Trim.IsEmpty then
      begin
        AConstraint.HasSchema(Schema);
      end;
    end);
end;

procedure TTableOperation.DefineSchemaAndTableForDependencies;
begin
  DefineSchemaAndTableForColumns;
  DefineSchemaAndTableForConstraints;
  DefineSchemaAndTableForIndexes;
end;

procedure TTableOperation.DefineSchemaAndTableForIndexes;
begin
  FIndexes.ForEach(
    procedure(const AIndex: IIndexOperation)
    begin
      if AIndex.Table.Trim.IsEmpty then
      begin
        AIndex.HasTable(Table);
      end;
      if AIndex.Schema.Trim.IsEmpty then
      begin
        AIndex.HasSchema(Schema);
      end;
    end);
end;

procedure TTableOperation.PrepareColumns;
begin
  FColumns.ForEach(
    procedure(const AColumn: IColumnOperation)
    begin
      AColumn.Prepare;
    end);
end;

procedure TTableOperation.PrepareConstraints;
begin
  FConstraints.ForEach(
    procedure(const AConstraint: IConstraintOperation)
    begin
      AConstraint.Prepare;
    end);
end;

procedure TTableOperation.PrepareDependencies;
begin
  PrepareColumns;
  PrepareConstraints;
  PrepareIndexes;
end;

procedure TTableOperation.PrepareIndexes;
begin
  FIndexes.ForEach(
    procedure(const AIndex: IIndexOperation)
    begin
      AIndex.Prepare;
    end);
end;

end.
