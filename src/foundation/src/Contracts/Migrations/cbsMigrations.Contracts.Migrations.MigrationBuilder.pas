unit cbsMigrations.Contracts.Migrations.MigrationBuilder;

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
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation,
  cbsMigrations.Contracts.Migrations.Operations.PrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.SqlOperation,
  cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation,
  cbsMigrations.Schema.Types,
{SPRING}
  Spring.Collections;

type
  IOperation = IMigrationOperation;
  IOperations = IReadOnlyCollection<IOperation>;

  IMigrationBuilder = interface(IUnknown)
    ['{75518ED9-6E90-4DCF-9F7A-F33147DE21AA}']
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
    function CreateTable(const AName: string): ICreateTableOperation;
    function DropCheckConstraint(const AName: string): IDropCheckConstraintOperation;
    function DropColumn(const AName: string): IDropColumnOperation;
    function DropForeignKey(const AName: string): IDropForeignKeyOperation;
    function DropIndex(const AName: string): IDropIndexOperation;
    function DropPrimaryKey(const AName: string): IDropPrimaryKeyOperation;
    function DropSchema(const AName: string): IDropSchemaOperation;
    function DropTable(const AName: string): IDropTableOperation;
    function DropUnique(const AName: string): IDropUniqueConstraintOperation;
    function EnsureSchema(const AName: string): IEnsureSchemaOperation;
    function GetDriverID: DriverID;
    function Operations: IOperations;
    function RenameColumn(const AName, ANewName: string): IRenameColumnOperation;
    function Sql(const ASql: string): ISqlOperation;
    property DriverID: DriverID read GetDriverID;
  end;

  IOperationList = IList<IOperation>;

  function CreateOperationList: IOperationList;

implementation

function CreateOperationList: IOperationList;
begin
  Result := TCollections.CreateInterfaceList<IOperation>;
end;

end.
