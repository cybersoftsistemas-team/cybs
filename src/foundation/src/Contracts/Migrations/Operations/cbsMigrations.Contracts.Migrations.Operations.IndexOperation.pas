unit cbsMigrations.Contracts.Migrations.Operations.IndexOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.NamedMigrationObjectOperation,
{SPRING}
  Spring.Collections;

type
  TIndexColumn = string;
  IIndexColumns = IEnumerable<TIndexColumn>;

  TDescending = array of Boolean;

  IIndexOperation = interface(INamedMigrationObjectOperation)
    ['{0682B95D-B92E-4DE3-A522-F4F3474110AA}']
    function Columns: IIndexColumns;
    function GetDescending: TDescending;
    function GetFilter: string;
    function GetUnique: Boolean;
    function HasColumns(const AColumns: array of TIndexColumn): IIndexOperation;
    function HasDescending(const ADescending: TDescending): IIndexOperation;
    function HasName(const AName: string): IIndexOperation;
    function HasSchema(const ASchema: string): IIndexOperation;
    function HasTable(const ATable: string): IIndexOperation;
    function HasUnique(const AUnique: Boolean): IIndexOperation;
    property Descending: TDescending read GetDescending;
    property Filter: string read GetFilter;
    property Unique: Boolean read GetUnique;
  end;

  IIndexColumnList = IList<TIndexColumn>;

  function CreateIndexColumnList: IIndexColumnList;

implementation

function CreateIndexColumnList: IIndexColumnList;
begin
  Result := TCollections.CreateList<TIndexColumn>;
end;

end.
