unit cbsMigrations.Migrations.MigrationBuilder;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddBooleanColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddDateColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddDateTimeColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddFloatColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddGuidColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddIntColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddPrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddStringColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddUniqueConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.AlterColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.CreateIndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.CreateTableOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropCheckConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropIndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropPrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropSchemaOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropTableOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropUniqueConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.EnsureSchemaOperation,
  cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.IndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.PrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.SqlOperation,
  cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation,
  cbsMigrations.Contracts.Migrations.MigrationBuilder,
  cbsMigrations.Schema.Types;

type
  TMigrationBuilder = class(TInterfacedObject, IMigrationBuilder)
  private
    FDriverID: DriverID;
    FOperations: IOperationList;
    function GetDriverID: DriverID;
  public
    constructor Create(const ADriverID: DriverID);
    destructor Destroy; override;
    function AddBooleanColumn(const AName, ATable: string): IAddBooleanColumnOperation;
    function AddDateColumn(const AName, ATable: string): IAddDateColumnOperation;
    function AddDateTimeColumn(const AName, ATable: string): IAddDateTimeColumnOperation;
    function AddFloatColumn(const AName, ATable: string): IAddFloatColumnOperation;
    function AddForeignKey(const AName, ATable: string; const AColumn: TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumn: TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function AddForeignKey(const AName, ATable: string; const AColumns: array of TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function AddForeignKey(const ATable: string; const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function AddForeignKey(const ATable: string; const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumn: TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function AddForeignKey(const ATable: string; const AColumns: array of TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable; const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation; overload;
    function AddGuidColumn(const AName, ATable: string): IAddGuidColumnOperation;
    function AddIntColumn(const AName, ATable: string): IAddIntColumnOperation;
    function AddPrimaryKey(const AName, ATable: string; const AColumn: TPrimaryKeyColumn): IAddPrimaryKeyOperation; overload;
    function AddPrimaryKey(const AName, ATable: string; const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation; overload;
    function AddPrimaryKey(const ATable: string; const AColumn: TPrimaryKeyColumn): IAddPrimaryKeyOperation; overload;
    function AddPrimaryKey(const ATable: string; const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation; overload;
    function AddStringColumn(const AName, ATable: string): IAddStringColumnOperation;
    function AddUnique(const AName, ATable: string; const AColumn: TUniqueColumn): IAddUniqueConstraintOperation; overload;
    function AddUnique(const AName, ATable: string; const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation; overload;
    function AddUnique(const ATable: string; const AColumn: TUniqueColumn): IAddUniqueConstraintOperation; overload;
    function AddUnique(const ATable: string; const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation; overload;
    function AlterColumn(const AName: string): IAlterColumnOperation;
    function CreateIndex(const AName, ATable: string; const AColumn: TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation; overload;
    function CreateIndex(const AName, ATable: string; const AColumns: array of TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation; overload;
    function CreateIndex(const ATable: string; const AColumn: TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation; overload;
    function CreateIndex(const ATable: string; const AColumns: array of TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation; overload;
    function CreateTable(const AName: string): ICreateTableOperation; overload;
    function CreateTable(const AName, ASchema: string): ICreateTableOperation; overload;
    function DropCheckConstraint(const AName: string): IDropCheckConstraintOperation;
    function DropColumn(const AName: string): IDropColumnOperation;
    function DropForeignKey(const AName: string): IDropForeignKeyOperation;
    function DropIndex(const AName: string): IDropIndexOperation;
    function DropPrimaryKey(const AName: string): IDropPrimaryKeyOperation;
    function DropSchema(const AName: string): IDropSchemaOperation;
    function DropTable(const AName: string): IDropTableOperation;
    function DropUnique(const AName: string): IDropUniqueConstraintOperation;
    function EnsureSchema(const AName: string): IEnsureSchemaOperation;
    function Operations: IOperations;
    function RenameColumn(const AName, ANewName: string): IRenameColumnOperation;
    function Sql(const ASql: string): ISqlOperation;
    property DriverID: DriverID read GetDriverID;
  end;

implementation

uses
{PROJECT}
  cbsMigrations.Migrations.Operations.AddBooleanColumnOperation,
  cbsMigrations.Migrations.Operations.AddDateColumnOperation,
  cbsMigrations.Migrations.Operations.AddDateTimeColumnOperation,
  cbsMigrations.Migrations.Operations.AddFloatColumnOperation,
  cbsMigrations.Migrations.Operations.AddForeignKeyOperation,
  cbsMigrations.Migrations.Operations.AddGuidColumnOperation,
  cbsMigrations.Migrations.Operations.AddIntColumnOperation,
  cbsMigrations.Migrations.Operations.AddPrimaryKeyOperation,
  cbsMigrations.Migrations.Operations.AddStringColumnOperation,
  cbsMigrations.Migrations.Operations.AddUniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.AlterColumnOperation,
  cbsMigrations.Migrations.Operations.CreateIndexOperation,
  cbsMigrations.Migrations.Operations.CreateTableOperation,
  cbsMigrations.Migrations.Operations.DropCheckConstraintOperation,
  cbsMigrations.Migrations.Operations.DropColumnOperation,
  cbsMigrations.Migrations.Operations.DropForeignKeyOperation,
  cbsMigrations.Migrations.Operations.DropIndexOperation,
  cbsMigrations.Migrations.Operations.DropPrimaryKeyOperation,
  cbsMigrations.Migrations.Operations.DropSchemaOperation,
  cbsMigrations.Migrations.Operations.DropTableOperation,
  cbsMigrations.Migrations.Operations.DropUniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.EnsureSchemaOperation,
  cbsMigrations.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Migrations.Operations.SqlOperation;

{ TMigrationBuilder }

constructor TMigrationBuilder.Create(const ADriverID: DriverID);
begin
  inherited Create;
  FDriverID := ADriverID;
  FOperations := CreateOperationList;
end;

destructor TMigrationBuilder.Destroy;
begin
  FOperations.Clear;
  FOperations := nil;
  inherited;
end;

function TMigrationBuilder.AddBooleanColumn(const AName, ATable: string): IAddBooleanColumnOperation;
var
  LOperation: IAddBooleanColumnOperation;
begin
  LOperation := TAddBooleanColumnOperation.Create(AName)
   .HasTable(ATable)
   .IsOptional;
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddDateColumn(const AName, ATable: string): IAddDateColumnOperation;
var
  LOperation: IAddDateColumnOperation;
begin
  LOperation := TAddDateColumnOperation.Create(AName)
   .HasTable(ATable)
   .IsOptional;
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddDateTimeColumn(const AName, ATable: string): IAddDateTimeColumnOperation;
var
  LOperation: IAddDateTimeColumnOperation;
begin
  LOperation := TAddDateTimeColumnOperation.Create(AName)
   .HasTable(ATable)
   .IsOptional;
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddFloatColumn(const AName, ATable: string): IAddFloatColumnOperation;
var
  LOperation: IAddFloatColumnOperation;
begin
  LOperation := TAddFloatColumnOperation.Create(AName)
   .HasTable(ATable)
   .IsOptional;
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddForeignKey(const ATable: string; const AColumns: array of TForeignKeyColumn;
  const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := AddForeignKey('', ATable, AColumns, APrincipalTable, APrincipalColumns);
end;

function TMigrationBuilder.AddForeignKey(const AName, ATable: string; const AColumn: TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumn: TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := AddForeignKey(AName, ATable, [AColumn], APrincipalTable, [APrincipalColumn]);
end;

function TMigrationBuilder.AddForeignKey(const AName, ATable: string; const AColumns: array of TForeignKeyColumn; const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
var
  LOperation: IAddForeignKeyOperation;
begin
  LOperation := TAddForeignKeyOperation.Create(AName)
   .HasColumns(AColumns)
   .HasPrincipalColumns(APrincipalColumns)
   .HasPrincipalTable(APrincipalTable)
   .HasTable(ATable);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddForeignKey(const ATable: string; const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumns: array of TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := AddForeignKey('', ATable, [], APrincipalTable, APrincipalColumns);
end;

function TMigrationBuilder.AddForeignKey(const ATable: string; const APrincipalTable: TForeignKeyPrincipalTable;
  const APrincipalColumn: TForeignKeyPrincipalColumn): IAddForeignKeyOperation;
begin
  Result := AddForeignKey('', ATable, [], APrincipalTable, [APrincipalColumn]);
end;

function TMigrationBuilder.AddGuidColumn(const AName, ATable: string): IAddGuidColumnOperation;
var
  LOperation: IAddGuidColumnOperation;
begin
  LOperation := TAddGuidColumnOperation.Create(AName)
   .HasTable(ATable)
   .IsOptional;
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddIntColumn(const AName, ATable: string): IAddIntColumnOperation;
var
  LOperation: IAddIntColumnOperation;
begin
  LOperation := TAddIntColumnOperation.Create(AName)
   .HasTable(ATable)
   .IsOptional;
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddPrimaryKey(const AName, ATable: string; const AColumn: TPrimaryKeyColumn): IAddPrimaryKeyOperation;
begin
  Result := AddPrimaryKey(AName, ATable, [AColumn]);
end;

function TMigrationBuilder.AddPrimaryKey(const AName, ATable: string;
  const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation;
var
  LOperation: IAddPrimaryKeyOperation;
begin
  LOperation := TAddPrimaryKeyOperation.Create(AName)
   .HasColumns(AColumns)
   .HasTable(ATable);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddPrimaryKey(const ATable: string; const AColumn: TPrimaryKeyColumn): IAddPrimaryKeyOperation;
begin
  Result := AddPrimaryKey('', ATable, [AColumn]);
end;

function TMigrationBuilder.AddPrimaryKey(const ATable: string;
  const AColumns: array of TPrimaryKeyColumn): IAddPrimaryKeyOperation;
begin
  Result := AddPrimaryKey('', ATable, AColumns);
end;

function TMigrationBuilder.AddStringColumn(const AName, ATable: string): IAddStringColumnOperation;
var
  LOperation: IAddStringColumnOperation;
begin
  LOperation := TAddStringColumnOperation.Create(AName)
   .HasTable(ATable)
   .IsOptional;
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddUnique(const AName, ATable: string; const AColumn: TUniqueColumn): IAddUniqueConstraintOperation;
begin
  Result := AddUnique(AName, ATable, [AColumn]);
end;

function TMigrationBuilder.AddUnique(const AName, ATable: string; const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation;
var
  LOperation: IAddUniqueConstraintOperation;
begin
  LOperation := TAddUniqueConstraintOperation.Create(AName)
   .HasColumns(AColumns)
    .HasTable(ATable);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.AddUnique(const ATable: string; const AColumn: TUniqueColumn): IAddUniqueConstraintOperation;
begin
  Result := AddUnique('', ATable, [AColumn]);
end;

function TMigrationBuilder.AddUnique(const ATable: string; const AColumns: array of TUniqueColumn): IAddUniqueConstraintOperation;
begin
  Result := AddUnique('', ATable, AColumns);
end;

function TMigrationBuilder.AlterColumn(const AName: string): IAlterColumnOperation;
var
  LOperation: IAlterColumnOperation;
begin
  LOperation := TAlterColumnOperation.Create(AName)
   .IsOptional;
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.CreateIndex(const ATable: string; const AColumn: TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation;
begin
  Result := CreateIndex('', ATable, AColumn, AUnique);
end;

function TMigrationBuilder.CreateIndex(const ATable: string; const AColumns: array of TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation;
begin
  Result := CreateIndex('', ATable, AColumns, AUnique);
end;

function TMigrationBuilder.CreateIndex(const AName, ATable: string; const AColumn: TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation;
begin
  Result := CreateIndex(AName, ATable, [AColumn], AUnique);
end;

function TMigrationBuilder.CreateIndex(const AName, ATable: string; const AColumns: array of TIndexColumn; const AUnique: Boolean = False): ICreateIndexOperation;
var
  LOperation: ICreateIndexOperation;
begin
  LOperation := TCreateIndexOperation.Create
   .HasColumns(AColumns)
   .HasName(AName)
   .HasTable(ATable)
   .HasUnique(AUnique);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.CreateTable(const AName: string): ICreateTableOperation;
begin
  Result := CreateTable(AName, '');
end;

function TMigrationBuilder.CreateTable(const AName, ASchema: string): ICreateTableOperation;
var
  LOperation: ICreateTableOperation;
begin
  LOperation := TCreateTableOperation.Create(AName)
   .HasSchema(ASchema);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.DropCheckConstraint(const AName: string): IDropCheckConstraintOperation;
var
  LOperation: IDropCheckConstraintOperation;
begin
  LOperation := TDropCheckConstraintOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.DropColumn(const AName: string): IDropColumnOperation;
var
  LOperation: IDropColumnOperation;
begin
  LOperation := TDropColumnOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.DropForeignKey(const AName: string): IDropForeignKeyOperation;
var
  LOperation: IDropForeignKeyOperation;
begin
  LOperation := TDropForeignKeyOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.DropIndex(const AName: string): IDropIndexOperation;
var
  LOperation: IDropIndexOperation;
begin
  LOperation := TDropIndexOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.DropPrimaryKey(const AName: string): IDropPrimaryKeyOperation;
var
  LOperation: IDropPrimaryKeyOperation;
begin
  LOperation := TDropPrimaryKeyOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.DropSchema(const AName: string): IDropSchemaOperation;
var
  LOperation: IDropSchemaOperation;
begin
  LOperation := TDropSchemaOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.DropTable(const AName: string): IDropTableOperation;
var
  LOperation: IDropTableOperation;
begin
  LOperation := TDropTableOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.DropUnique(const AName: string): IDropUniqueConstraintOperation;
var
  LOperation: IDropUniqueConstraintOperation;
begin
  LOperation := TDropUniqueConstraintOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.EnsureSchema(const AName: string): IEnsureSchemaOperation;
var
  LOperation: IEnsureSchemaOperation;
begin
  LOperation := TEnsureSchemaOperation.Create(AName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.GetDriverID: DriverID;
begin
  Result := FDriverID;
end;

function TMigrationBuilder.Operations: IOperations;
begin
  Result := FOperations;
end;

function TMigrationBuilder.RenameColumn(const AName, ANewName: string): IRenameColumnOperation;
var
  LOperation: IRenameColumnOperation;
begin
  LOperation := TRenameColumnOperation.Create(AName, ANewName);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

function TMigrationBuilder.Sql(const ASql: string): ISqlOperation;
var
  LOperation: ISqlOperation;
begin
  LOperation := TSqlOperation.Create
   .HasSql(ASql);
  FOperations.Add(LOperation);
  Result := LOperation;
end;

end.
