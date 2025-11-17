unit cbsMigrations.Migrations.Operations.PrimaryKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.PrimaryKeyOperation,
  cbsMigrations.Migrations.Operations.ConstraintOperation;

type
  TPrimaryKeyOperation = class(TConstraintOperation, IPrimaryKeyOperation)
  private
    FColumns: IPrimaryKeyColumnList;
    procedure AddColumn(const AColumn: TPrimaryKeyColumn);
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const AName: string);
    destructor Destroy; override;
    function Columns: TPrimaryKeyColumns;
    function HasColumns(const AColumns: array of TPrimaryKeyColumn): IPrimaryKeyOperation;
    function HasSchema(const ASchema: string): IPrimaryKeyOperation;
    function HasTable(const ATable: string): IPrimaryKeyOperation;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TPrimaryKeyOperation }

constructor TPrimaryKeyOperation.Create(const AName: string);
begin
  inherited Create(AName);
  FColumns := CreatePrimaryKeyColumnList;
end;

destructor TPrimaryKeyOperation.Destroy;
begin
  FColumns.Clear;
  FColumns := nil;
  inherited;
end;

function TPrimaryKeyOperation.Columns: TPrimaryKeyColumns;
begin
  Result := FColumns;
end;

function TPrimaryKeyOperation.HasColumns(const AColumns: array of TPrimaryKeyColumn): IPrimaryKeyOperation;
begin
  for var LColumn in AColumns do
  begin
    AddColumn(LColumn);
  end;
  Result := Self;
end;

function TPrimaryKeyOperation.HasSchema(const ASchema: string): IPrimaryKeyOperation;
begin
  Result := TPrimaryKeyOperation(inherited HasSchema(ASchema));
end;

function TPrimaryKeyOperation.HasTable(const ATable: string): IPrimaryKeyOperation;
begin
  Result := TPrimaryKeyOperation(inherited HasTable(ATable));
end;

procedure TPrimaryKeyOperation.AddColumn(const AColumn: TPrimaryKeyColumn);
begin
  if not FColumns.Contains(AColumn) then
  begin
    FColumns.Add(AColumn);
  end;
end;

procedure TPrimaryKeyOperation.DoPrepare;
begin
  if not Table.Trim.IsEmpty and Name.Trim.IsEmpty then
  begin
    SetName(Format('PK_%s_%s', [QualifiedTableName('_'), string.Join('_', FColumns.ToArray)]));
  end;
end;

end.
