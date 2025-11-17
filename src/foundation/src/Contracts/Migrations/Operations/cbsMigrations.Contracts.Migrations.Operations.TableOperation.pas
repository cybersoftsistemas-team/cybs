unit cbsMigrations.Contracts.Migrations.Operations.TableOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.IndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.MigrationObjectOperation,
{SPRING}
  Spring.Collections;

type
  ITableColumns = IEnumerable<IColumnOperation>;
  ITableConstraints = IEnumerable<IConstraintOperation>;
  ITableIndexes = IEnumerable<IIndexOperation>;

  ITableOperation = interface(IMigrationObjectOperation)
    ['{D5997995-4F79-453D-BACC-93D804DC883A}']
    function Columns: ITableColumns; overload;
    function Columns(const AColumns: array of IColumnOperation): ITableOperation; overload;
    function Constraints: ITableConstraints; overload;
    function Constraints(const AConstraints: array of IConstraintOperation): ITableOperation; overload;
    function HasSchema(const ASchema: string): ITableOperation;
    function Indexes: ITableIndexes; overload;
    function Indexes(const AIndexes: array of IIndexOperation): ITableOperation; overload;
  end;

  ITableColumnList = IList<IColumnOperation>;
  ITableConstraintList = IList<IConstraintOperation>;
  ITableIndexList = IList<IIndexOperation>;

  function CreateTableColumnList: ITableColumnList;
  function CreateTableConstraintList: ITableConstraintList;
  function CreateTableIndexList: ITableIndexList;

implementation

function CreateTableColumnList: ITableColumnList;
begin
  Result := TCollections.CreateInterfaceList<IColumnOperation>;
end;

function CreateTableConstraintList: ITableConstraintList;
begin
  Result := TCollections.CreateInterfaceList<IConstraintOperation>;
end;

function CreateTableIndexList: ITableIndexList;
begin
  Result := TCollections.CreateInterfaceList<IIndexOperation>;
end;

end.
