unit cbsMigrations.Migrations.Operations.ForeignKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation,
  cbsMigrations.Migrations.Operations.ConstraintOperation;

type
  TForeignKeyOperation = class(TConstraintOperation, IForeignKeyOperation)
  private
    FColumns: IForeignKeyColumnList;
    FOnDelete: ReferentialAction;
    FOnUpdate: ReferentialAction;
    FPrincipalColumns: IForeignKeyPrincipalColumnList;
    FPrincipalSchema: string;
    FPrincipalTable: string;
    function GetOnDelete: ReferentialAction;
    function GetOnUpdate: ReferentialAction;
    function GetPrincipalSchema: string;
    function GetPrincipalTable: string;
    procedure AddColumn(const AColumn: TForeignKeyColumn);
    procedure AddPrincipalColumn(const AColumn: TForeignKeyPrincipalColumn);
  protected
    procedure DoPrepare; override;
  public
    constructor Create(const AName: string);
    destructor Destroy; override;
    function Columns: IForeignKeyColumns;
    function HasColumns(const AColumns: array of TForeignKeyColumn): IForeignKeyOperation;
    function HasOnDelete(const Action: ReferentialAction): IForeignKeyOperation;
    function HasOnUpdate(const Action: ReferentialAction): IForeignKeyOperation;
    function HasPrincipalColumns(const AColumns: array of TForeignKeyPrincipalColumn): IForeignKeyOperation;
    function HasPrincipalSchema(const ASchema: string): IForeignKeyOperation;
    function HasPrincipalTable(const ATable: string): IForeignKeyOperation;
    function HasSchema(const ASchema: string): IForeignKeyOperation;
    function HasTable(const ATable: string): IForeignKeyOperation;
    function PrincipalColumns: IForeignKeyPrincipalColumns;
    function QualifiedPrincipalTableName(const ASeparator: Char = #0): string;
    property OnDelete: ReferentialAction read GetOnDelete;
    property OnUpdate: ReferentialAction read GetOnUpdate;
    property PrincipalSchema: string read GetPrincipalSchema;
    property PrincipalTable: string read GetPrincipalTable;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TForeignKeyOperation }

constructor TForeignKeyOperation.Create(const AName: string);
begin
  inherited Create(AName);
  FColumns := CreateForeignKeyColumnList;
  FPrincipalColumns := CreateForeignKeyPrincipalColumnList;
end;

destructor TForeignKeyOperation.Destroy;
begin
  FColumns.Clear;
  FPrincipalColumns.Clear;
  FColumns := nil;
  FPrincipalColumns := nil;
  inherited;
end;

function TForeignKeyOperation.Columns: IForeignKeyColumns;
begin
  Result := FColumns;
end;

function TForeignKeyOperation.HasColumns(const AColumns: array of TForeignKeyColumn): IForeignKeyOperation;
begin
  for var LColumn in AColumns do
  begin
    AddColumn(LColumn);
  end;
  Result := Self;
end;

function TForeignKeyOperation.HasOnDelete(const Action: ReferentialAction): IForeignKeyOperation;
begin
  FOnDelete := Action;
  Result := Self;
end;

function TForeignKeyOperation.HasOnUpdate(const Action: ReferentialAction): IForeignKeyOperation;
begin
  FOnUpdate := Action;
  Result := Self;
end;

function TForeignKeyOperation.HasPrincipalColumns(const AColumns: array of TForeignKeyPrincipalColumn): IForeignKeyOperation;
begin
  for var LColumn in AColumns do
  begin
    AddPrincipalColumn(LColumn);
  end;
  Result := Self;
end;

function TForeignKeyOperation.HasPrincipalSchema(const ASchema: string): IForeignKeyOperation;
begin
  FPrincipalSchema := ASchema;
  Result := Self;
end;

function TForeignKeyOperation.HasPrincipalTable(const ATable: string): IForeignKeyOperation;
begin
  FPrincipalTable := ATable;
  Result := Self;
end;

function TForeignKeyOperation.HasSchema(const ASchema: string): IForeignKeyOperation;
begin
  SetSchema(ASchema);
  Result := Self;
end;

function TForeignKeyOperation.HasTable(const ATable: string): IForeignKeyOperation;
begin
  SetTable(ATable);
  Result := Self;
end;

function TForeignKeyOperation.GetOnDelete: ReferentialAction;
begin
  Result := FOnDelete;
end;

function TForeignKeyOperation.GetOnUpdate: ReferentialAction;
begin
  Result := FOnUpdate;
end;

function TForeignKeyOperation.GetPrincipalSchema: string;
begin
  Result := FPrincipalSchema;
end;

function TForeignKeyOperation.GetPrincipalTable: string;
begin
  Result := FPrincipalTable;
end;

function TForeignKeyOperation.PrincipalColumns: IForeignKeyPrincipalColumns;
begin
  Result := FPrincipalColumns;
end;

function TForeignKeyOperation.QualifiedPrincipalTableName(const ASeparator: Char): string;
begin
  Result := QualifiedTableName(FPrincipalTable, FPrincipalSchema, ASeparator);
end;

procedure TForeignKeyOperation.AddColumn(const AColumn: TForeignKeyColumn);
begin
  if not FColumns.Contains(AColumn) then
  begin
    FColumns.Add(AColumn);
  end;
end;

procedure TForeignKeyOperation.AddPrincipalColumn(const AColumn: TForeignKeyPrincipalColumn);
begin
  if not FPrincipalColumns.Contains(AColumn) then
  begin
    FPrincipalColumns.Add(AColumn);
  end;
end;

procedure TForeignKeyOperation.DoPrepare;
begin
  if FColumns.IsEmpty then
  begin
    FColumns.AddRange(FPrincipalColumns);
  end;
  if FPrincipalSchema.Trim.IsEmpty then
  begin
    FPrincipalSchema := Schema;
  end;
  if not Table.Trim.IsEmpty and Name.Trim.IsEmpty then
  begin
    SetName(Format('FK_%s_%s_%s', [QualifiedTableName('_'), QualifiedPrincipalTableName('_'),
      string.Join('_', FColumns.ToArray)]));
  end;
end;

end.
