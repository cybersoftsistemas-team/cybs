unit cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
{SPRING}
  Spring.Collections;

type
{$SCOPEDENUMS ON}
  ReferentialAction = (
    NoAction,
    Restrict,
    Cascade,
    SetNull,
    SetDefault
  );
{$SCOPEDENUMS OFF}

  TForeignKeyColumn = string;
  TForeignKeyPrincipalColumn = TForeignKeyColumn;
  TForeignKeyPrincipalTable = TForeignKeyColumn;

  IForeignKeyColumns = IEnumerable<TForeignKeyColumn>;
  IForeignKeyPrincipalColumns = IEnumerable<TForeignKeyColumn>;

  IForeignKeyOperation = interface(IConstraintOperation)
    ['{4B8DEB45-ABCE-4D5C-84D4-3C016D0C7982}']
    function Columns: IForeignKeyColumns;
    function GetOnDelete: ReferentialAction;
    function GetOnUpdate: ReferentialAction;
    function GetPrincipalSchema: string;
    function GetPrincipalTable: string;
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

  IForeignKeyColumnList = IList<TForeignKeyColumn>;
  IForeignKeyPrincipalColumnList = IList<TForeignKeyPrincipalColumn>;

  function CreateForeignKeyColumnList: IForeignKeyColumnList;
  function CreateForeignKeyPrincipalColumnList: IForeignKeyPrincipalColumnList;

implementation

function CreateForeignKeyColumnList: IForeignKeyColumnList;
begin
  Result := TCollections.CreateList<TForeignKeyColumn>;
end;

function CreateForeignKeyPrincipalColumnList: IForeignKeyPrincipalColumnList;
begin
  Result := TCollections.CreateList<TForeignKeyPrincipalColumn>;
end;

end.
