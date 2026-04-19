unit cbsMigrations.Migrations.Operations.UniqueConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.ConstraintOperation,
  cbsMigrations.Migrations.Operations.IncludeColumn;

type
  TUniqueConstraintOperation = class(TConstraintOperation, IUniqueConstraintOperation)
  private
    FColumns: IUniqueColumnList;
    procedure AddColumn(const AColumn: TUniqueColumn);
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const AName: string);
    destructor Destroy; override;
    function Columns: IUniqueColumns;
    function HasColumn(const AColumnName: TUniqueColumn): IUniqueConstraintOperation;
    function HasColumns(const AColumns: array of TUniqueColumn): IUniqueConstraintOperation;
    function HasSchema(const ASchema: string): IUniqueConstraintOperation;
    function HasTable(const ATable: string): IUniqueConstraintOperation;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TUniqueConstraintOperation }

constructor TUniqueConstraintOperation.Create(const AName: string);
begin
  inherited Create(AName);
  FColumns := CreateUniqueColumnList;
end;

destructor TUniqueConstraintOperation.Destroy;
begin
  FColumns.Clear;
  FColumns := nil;
  inherited;
end;

function TUniqueConstraintOperation.Columns: IUniqueColumns;
begin
  Result := FColumns;
end;

function TUniqueConstraintOperation.HasColumn(const AColumnName: TUniqueColumn): IUniqueConstraintOperation;
begin
  Result := HasColumns([AColumnName]);
end;

function TUniqueConstraintOperation.HasColumns(const AColumns: array of TUniqueColumn): IUniqueConstraintOperation;
begin
  for var LColumn in AColumns do
  begin
    AddColumn(LColumn);
  end;
  Result := Self;
end;

function TUniqueConstraintOperation.HasSchema(const ASchema: string): IUniqueConstraintOperation;
begin
  Result := TUniqueConstraintOperation(inherited HasSchema(ASchema));
end;

function TUniqueConstraintOperation.HasTable(const ATable: string): IUniqueConstraintOperation;
begin
  Result := TUniqueConstraintOperation(inherited HasTable(ATable));
end;

procedure TUniqueConstraintOperation.AddColumn(const AColumn: TUniqueColumn);
begin
  if not FColumns.Contains(AColumn) then
  begin
    FColumns.Add(AColumn);
  end;
end;

procedure TUniqueConstraintOperation.DoPrepare;
begin
  if not Table.Trim.IsEmpty and Name.Trim.IsEmpty then
  begin
    SetName(Format('%s_%s_unique', [QualifiedTableName('_'), string.Join('_', FColumns.ToArray)]));
  end;
end;

end.
