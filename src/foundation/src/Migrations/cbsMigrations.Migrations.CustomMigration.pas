unit cbsMigrations.Migrations.CustomMigration;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.CommandBuilder,
  cbsMigrations.Contracts.Migrations.Migration,
  cbsMigrations.Contracts.Migrations.MigrationBuilder,
  cbsMigrations.Contracts.Migrations.Operations.AddBooleanColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddCheckConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddDateColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddDateTimeColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddFloatColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddGuidColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddIntColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddPrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddStringColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddUniqueConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.CreateIndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.CreateTableOperation,
  cbsMigrations.Contracts.Migrations.Operations.IndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.NumberColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.PrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.StringColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation,
  cbsMigrations.Migrations.MigrationBase,
  cbsMigrations.Schema.Types;

type
  TCustomMigration = class(TMigrationBase, IMigration)
  private
    FDownOperations: IDownOperationList;
    FDriverID: DriverID;
    FUpOperations: IUpOperationList;
    function BuildAction(const AOperations: IOperationList; const ABuldAction: TFunc<IOperations>): IOperations;
    function BuildOperations(const ABuildAction: TBuildOperantionEvent): IOperations;
    function CreateCommandBuilder: ICommandBuilder;
    procedure SetColumnType(const AOperation: ICreateTableOperation); overload;
    procedure SetColumnType(const AOperation: IStringColumnOperation; var ADbType: string; const ABuilder: ICommandBuilder); overload;
    procedure SetColumnType(const AOperation: INumberColumnOperation; var ADbType: string; const ABuilder: ICommandBuilder); overload;
    procedure SetColumnType(const AOperations: IOperations); overload;
  protected
    function BooleanColumn(const AName: string): IAddBooleanColumnOperation;
    function CheckConstraint(const AName, ASql: string): IAddCheckConstraintOperation;
    function CreateIndex(const AColumn: TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation; overload;
    function CreateIndex(const AColumns: array of TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation; overload;
    function CreateIndex(const AName: string; const AColumn: TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation; overload;
    function CreateIndex(const AName: string; const AColumns: array of TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation; overload;
    function DateColumn(const AName: string): IAddDateColumnOperation;
    function DateTimeColumn(const AName: string): IAddDateTimeColumnOperation;
    function FloatColumn(const AName: string): IAddFloatColumnOperation;
    function ForeignKey(const AColumn: TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumn: TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function ForeignKey(const AColumns: array of TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function ForeignKey(const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function ForeignKey(const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumn: TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function GuidColumn(const AName: string): IAddGuidColumnOperation;
    function IntColumn(const AName: string): IAddIntColumnOperation;
    function PrimaryKey(const AColumn: TPrimaryKeyColumn): IAddPrimaryKeyOperation; overload;
    function PrimaryKey(const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation; overload;
    function PrimaryKey(const AName: string; const AColumn: TPrimaryKeyColumn): IAddPrimaryKeyOperation; overload;
    function PrimaryKey(const AName: string; const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation; overload;
    function StringColumn(const AName: string): IAddStringColumnOperation;
    function Unique(const AColumn: TUniqueColumn): IAddUniqueConstraintOperation; overload;
    function Unique(const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation; overload;
    function Unique(const AName: string; const AColumn: TUniqueColumn): IAddUniqueConstraintOperation; overload;
    function Unique(const AName: string; const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation; overload;
  public
    constructor Create(const ADriverID: DriverID);
    destructor Destroy; override;
    function DownOperations: IDownOperations;
    function UpOperations: IUpOperations;
  end;

implementation

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation,
  cbsMigrations.Migrations.Operations.AddBooleanColumnOperation,
  cbsMigrations.Migrations.Operations.AddCheckConstraintOperation,
  cbsMigrations.Migrations.Operations.AddDateColumnOperation,
  cbsMigrations.Migrations.Operations.AddDateTimeColumnOperation,
  cbsMigrations.Migrations.Operations.AddFloatColumnOperation,
  cbsMigrations.Migrations.Operations.AddForeignKeyOperation,
  cbsMigrations.Migrations.Operations.AddGuidColumnOperation,
  cbsMigrations.Migrations.Operations.AddIntColumnOperation,
  cbsMigrations.Migrations.Operations.AddPrimaryKeyOperation,
  cbsMigrations.Migrations.Operations.AddStringColumnOperation,
  cbsMigrations.Migrations.Operations.AddUniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.CreateIndexOperation,
  cbsMigrations.Migrations.Operations.CreateTableOperation,
  cbsMigrations.Migrations.Operations.NumberColumnOperation,
  cbsMigrations.Migrations.Operations.StringColumnOperation,
  cbsMigrations.Migrations.CommandBuilder,
  cbsMigrations.Migrations.MigrationBuilder,
  cbsMigrations.Support.MappedColumnTypes;

{ CustomMigration }

constructor TCustomMigration.Create(const ADriverID: DriverID);
begin
  inherited Create;
  FDriverID := ADriverID;
  FDownOperations := CreateDownOperationList;
  FUpOperations := CreateUpOperationList;
end;

destructor TCustomMigration.Destroy;
begin
  FDownOperations.Clear;
  FUpOperations.Clear;
  FDownOperations := nil;
  FUpOperations := nil;
  inherited;
end;

function TCustomMigration.CreateCommandBuilder: ICommandBuilder;
begin
  Result := TCommandBuilder.Create;
end;

function TCustomMigration.DownOperations: IDownOperations;
begin
  Result := BuildAction(FDownOperations,
    function: IOperations
    begin
      Result := BuildOperations(Down);
    end);
end;

function TCustomMigration.BooleanColumn(const AName: string): IAddBooleanColumnOperation;
begin
  Result := TAddBooleanColumnOperation.Create(AName)
   .IsOptional;
end;

function TCustomMigration.BuildAction(const AOperations: IOperationList; const ABuldAction: TFunc<IOperations>): IOperations;
begin
  if AOperations.IsEmpty then
  begin
    AOperations.AddRange(ABuldAction);
  end;
  Result := AOperations;
end;

function TCustomMigration.BuildOperations(const ABuildAction: TBuildOperantionEvent): IOperations;
var
  LMigrationBuilder: IMigrationBuilder;
  LOperations: IOperationList;
begin
  LOperations := CreateOperationList;
  LMigrationBuilder := TMigrationBuilder.Create(FDriverID);
  ABuildAction(LMigrationBuilder);
  SetColumnType(LMigrationBuilder.Operations);
  LOperations.AddRange(LMigrationBuilder.Operations);
  Result := LOperations;
end;

function TCustomMigration.CheckConstraint(const AName, ASql: string): IAddCheckConstraintOperation;
begin
  Result := TAddCheckConstraintOperation.Create(AName, ASql);
end;

function TCustomMigration.CreateIndex(const AColumn: TIndexColumn; const AUnique: Boolean): ICreateIndexOperation;
begin
  Result := CreateIndex('', AColumn, AUnique);
end;

function TCustomMigration.CreateIndex(const AColumns: array of TIndexColumn; const AUnique: Boolean): ICreateIndexOperation;
begin
  Result := CreateIndex('', AColumns, AUnique);
end;

function TCustomMigration.CreateIndex(const AName: string; const AColumn: TIndexColumn; const AUnique: Boolean): ICreateIndexOperation;
begin
  Result := CreateIndex(AName, [AColumn], AUnique);
end;

function TCustomMigration.CreateIndex(const AName: string; const AColumns: array of TIndexColumn;
  const AUnique: Boolean): ICreateIndexOperation;
begin
  Result := TCreateIndexOperation.Create
   .HasColumns(AColumns)
   .HasName(AName)
   .HasUnique(AUnique);
end;

function TCustomMigration.DateColumn(const AName: string): IAddDateColumnOperation;
begin
  Result := TAddDateColumnOperation.Create(AName)
   .IsOptional;
end;

function TCustomMigration.DateTimeColumn(const AName: string): IAddDateTimeColumnOperation;
begin
  Result := TAddDateTimeColumnOperation.Create(AName)
   .IsOptional;
end;

function TCustomMigration.FloatColumn(const AName: string): IAddFloatColumnOperation;
begin
  Result := TAddFloatColumnOperation.Create(AName)
   .IsOptional;
end;

function TCustomMigration.ForeignKey(const AColumn: TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumn: TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := ForeignKey([AColumn], APrincipalTable, [APrincipalColumn]);
end;

function TCustomMigration.ForeignKey(const AColumns: array of TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := TAddForeignKeyOperation.Create('')
   .HasColumns(AColumns)
   .HasPrincipalColumns(APrincipalColumns)
   .HasPrincipalTable(APrincipalTable);
end;

function TCustomMigration.ForeignKey(const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumn: TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := ForeignKey([], APrincipalTable, [APrincipalColumn]);
end;

function TCustomMigration.ForeignKey(const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := ForeignKey([], APrincipalTable, APrincipalColumns);
end;

function TCustomMigration.GuidColumn(const AName: string): IAddGuidColumnOperation;
begin
  Result := TAddGuidColumnOperation.Create(AName)
   .IsOptional;
end;

function TCustomMigration.IntColumn(const AName: string): IAddIntColumnOperation;
begin
  Result := TAddIntColumnOperation.Create(AName)
   .IsOptional;
end;

function TCustomMigration.PrimaryKey(const AColumn: TPrimaryKeyColumn): IAddPrimaryKeyOperation;
begin
  Result := PrimaryKey([AColumn]);
end;

function TCustomMigration.PrimaryKey(const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation;
begin
  Result := PrimaryKey('', AColumns);
end;

function TCustomMigration.PrimaryKey(const AName: string; const AColumn: TPrimaryKeyColumn): IAddPrimaryKeyOperation;
begin
  Result := PrimaryKey(AName, [AColumn]);
end;

function TCustomMigration.PrimaryKey(const AName: string; const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation;
begin
  Result := TAddPrimaryKeyOperation.Create(AName)
    .HasColumns(AColumns);
end;

function TCustomMigration.StringColumn(const AName: string): IAddStringColumnOperation;
begin
  Result := TAddStringColumnOperation.Create(AName)
   .IsOptional;
end;

function TCustomMigration.Unique(const AColumn: TUniqueColumn): IAddUniqueConstraintOperation;
begin
  Result := Unique([AColumn]);
end;

function TCustomMigration.Unique(const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation;
begin
  Result := Unique('', AColumns);
end;

function TCustomMigration.Unique(const AName: string; const AColumn: TUniqueColumn): IAddUniqueConstraintOperation;
begin
  Result := Unique(AName, [AColumn]);
end;

function TCustomMigration.Unique(const AName: string; const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation;
begin
  Result := TAddUniqueConstraintOperation.Create(AName)
   .HasColumns(AColumns);
end;

function TCustomMigration.UpOperations: IUpOperations;
begin
  Result := BuildAction(FUpOperations,
    function: IOperations
    begin
      Result := BuildOperations(Up);
    end);
end;

procedure TCustomMigration.SetColumnType(const AOperation: ICreateTableOperation);
var
  LBuilder: ICommandBuilder;
  LColumnOperation: IColumnOperation;
  LDbType: string;
begin
  for LColumnOperation in AOperation.Columns do if
    LColumnOperation.ColumnType.Trim.IsEmpty then
  begin
    LDbType := MappedColumnTypes.GetDbType(LColumnOperation, FDriverID);
    if Supports(LColumnOperation, INumberColumnOperation) then
    begin
      LBuilder := CreateCommandBuilder;
      SetColumnType(TNumberColumnOperation(LColumnOperation), LDbType, LBuilder);
      LDbType := LBuilder.Build;
    end
    else if Supports(LColumnOperation, IStringColumnOperation) then
    begin
      LBuilder := CreateCommandBuilder;
      SetColumnType(TStringColumnOperation(LColumnOperation), LDbType, LBuilder);
      LDbType := LBuilder.Build;
    end;
    LColumnOperation.HasColumnType(LDbType);
  end;
end;

procedure TCustomMigration.SetColumnType(const AOperation: INumberColumnOperation; var ADbType: string;
  const ABuilder: ICommandBuilder);
begin
  ABuilder.Append(ADbType);
  if (FDriverID in LengthOrPrecisionSupport) and (AOperation.Precision > 0) then
  begin
    ABuilder.Append('(');
    ABuilder.Append(AOperation.Precision.ToString);
    ABuilder.Append(')');
  end;
end;

procedure TCustomMigration.SetColumnType(const AOperation: IStringColumnOperation; var ADbType: string;
  const ABuilder: ICommandBuilder);
begin
  if (FDriverID in ChatSupport) and AOperation.FixedLength then
  begin
    ADbType := 'CHAR';
  end;
  if (FDriverID in NSupport) and AOperation.Unicode then
  begin
    ABuilder.Append(Concat('N', ADbType));
  end
  else
  begin
    ABuilder.Append(ADbType);
  end;
  if (FDriverID in LengthOrPrecisionSupport) and (AOperation.Length > 0) then
  begin
    ABuilder.Append('(');
  end;
  if (FDriverID = DriverID.MSSQL) and AOperation.MaxLength and not AOperation.FixedLength then
  begin
    ABuilder.Append('MAX');
  end
  else if (FDriverID in LengthOrPrecisionSupport) and (AOperation.Length > 0) then
  begin
    ABuilder.Append(AOperation.Length.ToString);
  end;
  if (FDriverID in LengthOrPrecisionSupport) and (AOperation.Length > 0) then
  begin
    ABuilder.Append(')');
  end;
end;

procedure TCustomMigration.SetColumnType(const AOperations: IOperations);
begin
  AOperations.ForEach(
    procedure(const AOperation: IMigrationOperation)
    begin
      if Supports(AOperation, ICreateTableOperation) then
      begin
        SetColumnType(TCreateTableOperation(AOperation));
      end;
    end);
end;

end.
