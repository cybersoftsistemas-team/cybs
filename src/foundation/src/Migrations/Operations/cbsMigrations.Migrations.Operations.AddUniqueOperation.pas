unit cbsMigrations.Migrations.Operations.AddUniqueOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddUniqueOperation,
  cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.IncludeColumn,
  cbsMigrations.Migrations.Operations.UniqueConstraintOperation;

type
  TAddUniqueOperation = class(TUniqueConstraintOperation, IAddUniqueOperation)
  private
    FDescending: TDescending;
    FIncludeColumns: IIncludeColumnList;
    function GetDescending: TDescending;
    procedure AddIncludeColumn(const AIncludeColumn: TIncludeColumn);
  public
    constructor Create(const AName: string);
    destructor Destroy; override;
    function HasColumn(const AColumnName: TUniqueColumn): IAddUniqueOperation;
    function HasColumns(const AColumns: array of TUniqueColumn): IAddUniqueOperation;
    function HasDescending(const ADescending: TDescending): IAddUniqueOperation;
    function HasInclude(const AColumns: array of TIncludeColumn): IAddUniqueOperation;
    function HasSchema(const ASchema: string): IAddUniqueOperation;
    function HasTable(const ATable: string): IAddUniqueOperation;
    function IncludeColumns: IIncludeColumns;
    property Descending: TDescending read GetDescending;
  end;

implementation

{ TAddUniqueOperation }

constructor TAddUniqueOperation.Create(const AName: string);
begin
  inherited Create(AName);
  FIncludeColumns := CreateIncludeColumnList;
end;

destructor TAddUniqueOperation.Destroy;
begin
  FIncludeColumns.Clear;
  FIncludeColumns := nil;
  inherited;
end;

function TAddUniqueOperation.GetDescending: TDescending;
begin
  Result := FDescending;
end;

function TAddUniqueOperation.HasColumn(const AColumnName: TUniqueColumn): IAddUniqueOperation;
begin
  Result := TAddUniqueOperation(inherited HasColumn(AColumnName));
end;

function TAddUniqueOperation.HasColumns(const AColumns: array of TUniqueColumn): IAddUniqueOperation;
begin
  Result := TAddUniqueOperation(inherited HasColumns(AColumns));
end;

function TAddUniqueOperation.HasDescending(const ADescending: TDescending): IAddUniqueOperation;
begin
  FDescending := ADescending;
  Result := Self;
end;

function TAddUniqueOperation.HasInclude(const AColumns: array of TIncludeColumn): IAddUniqueOperation;
begin
  for var LIncludeColumn in AColumns do
  begin
    AddIncludeColumn(LIncludeColumn);
  end;
  Result := Self;
end;

function TAddUniqueOperation.HasSchema(const ASchema: string): IAddUniqueOperation;
begin
  Result := TAddUniqueOperation(inherited HasSchema(ASchema));
end;

function TAddUniqueOperation.HasTable(const ATable: string): IAddUniqueOperation;
begin
  Result := TAddUniqueOperation(inherited HasTable(ATable));
end;

function TAddUniqueOperation.IncludeColumns: IIncludeColumns;
begin
  Result := FIncludeColumns;
end;

procedure TAddUniqueOperation.AddIncludeColumn(const AIncludeColumn: TIncludeColumn);
begin
  if not FIncludeColumns.Contains(AIncludeColumn) then
  begin
    FIncludeColumns.Add(AIncludeColumn);
  end;
end;

end.
