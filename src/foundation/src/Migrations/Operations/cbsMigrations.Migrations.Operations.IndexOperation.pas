unit cbsMigrations.Migrations.Operations.IndexOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.IndexOperation,
  cbsMigrations.Migrations.Operations.NamedMigrationObjectOperation;

type
  TIndexOperation = class(TNamedMigrationObjectOperation, IIndexOperation)
  private
    FColumns: IIndexColumnList;
    FDescending: TDescending;
    FFilter: string;
    FIncludeColumns: IIncludeColumnList;
    FUnique: Boolean;
    function GetDescending: TDescending;
    function GetFilter: string;
    function GetUnique: Boolean;
    procedure AddColumn(const AColumn: TIndexColumn);
    procedure AddIncludeColumn(const AIncludeColumn: TIncludeColumn);
  protected
    procedure DoPrepare; override;
  public
    constructor Create;
    destructor Destroy; override;
    function Columns: IIndexColumns;
    function HasColumns(const AColumns: array of TIndexColumn): IIndexOperation;
    function HasDescending(const ADescending: TDescending): IIndexOperation;
    function HasInclude(const AColumns: array of TIncludeColumn): IIndexOperation;
    function HasName(const AName: string): IIndexOperation;
    function HasSchema(const ASchema: string): IIndexOperation;
    function HasTable(const ATable: string): IIndexOperation;
    function HasUnique(const AUnique: Boolean): IIndexOperation;
    function IncludeColumns: IIncludeColumns;
    property Descending: TDescending read GetDescending;
    property Filter: string read GetFilter;
    property Unique: Boolean read GetUnique;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TIndexOperation }

constructor TIndexOperation.Create;
begin
  inherited Create('');
  FColumns := CreateIndexColumnList;
  FIncludeColumns := CreateIncludeColumnList;
end;

destructor TIndexOperation.Destroy;
begin
  FColumns.Clear;
  FIncludeColumns.Clear;
  FColumns := nil;
  FIncludeColumns := nil;
  inherited;
end;

function TIndexOperation.Columns: IIndexColumns;
begin
  Result := FColumns;
end;

function TIndexOperation.GetDescending: TDescending;
begin
  Result := FDescending;
end;

function TIndexOperation.GetFilter: string;
begin
  Result := FFilter;
end;

function TIndexOperation.GetUnique: Boolean;
begin
  Result := FUnique;
end;

function TIndexOperation.HasColumns(const AColumns: array of TIndexColumn): IIndexOperation;
begin
  for var LColumn in AColumns do
  begin
    AddColumn(LColumn);
  end;
  Result := Self;
end;

function TIndexOperation.HasDescending(const ADescending: TDescending): IIndexOperation;
begin
  FDescending := ADescending;
  Result := Self;
end;

function TIndexOperation.HasInclude(const AColumns: array of TIncludeColumn): IIndexOperation;
begin
  for var LIncludeColumn in AColumns do
  begin
    AddIncludeColumn(LIncludeColumn);
  end;
  Result := Self;
end;

function TIndexOperation.HasName(const AName: string): IIndexOperation;
begin
  SetName(AName);
  Result := Self;
end;

function TIndexOperation.HasSchema(const ASchema: string): IIndexOperation;
begin
  SetSchema(ASchema);
  Result := Self;
end;

function TIndexOperation.HasTable(const ATable: string): IIndexOperation;
begin
  SetTable(ATable);
  Result := Self;
end;

function TIndexOperation.HasUnique(const AUnique: Boolean): IIndexOperation;
begin
  FUnique := AUnique;
  Result := Self;
end;

function TIndexOperation.IncludeColumns: IIncludeColumns;
begin
  Result := FIncludeColumns;
end;

procedure TIndexOperation.AddColumn(const AColumn: TIndexColumn);
begin
  if not FColumns.Contains(AColumn) then
  begin
    FColumns.Add(AColumn);
  end;
end;

procedure TIndexOperation.AddIncludeColumn(const AIncludeColumn: TIncludeColumn);
begin
  if not FIncludeColumns.Contains(AIncludeColumn) then
  begin
    FIncludeColumns.Add(AIncludeColumn);
  end;
end;

procedure TIndexOperation.DoPrepare;
begin
  if not Table.Trim.IsEmpty and Name.Trim.IsEmpty then
  begin
    SetName(Format('IX_%s_%s', [QualifiedTableName('_'), string.Join('_', FColumns.ToArray)]));
  end;
end;

end.
