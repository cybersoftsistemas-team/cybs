unit cbsMigrations.Contracts.Migrations.Operations.PrimaryKeyOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
{SPRING}
  Spring.Collections;

type
  TPrimaryKeyColumn = string;
  TPrimaryKeyColumns = IEnumerable<TPrimaryKeyColumn>;

  IPrimaryKeyOperation = interface(IConstraintOperation)
    ['{19435A90-4BB8-4668-9BD6-498F3D7B3B5B}']
    function Columns: TPrimaryKeyColumns;
    function HasColumns(const AColumns: array of TPrimaryKeyColumn): IPrimaryKeyOperation;
    function HasSchema(const ASchema: string): IPrimaryKeyOperation;
    function HasTable(const ATable: string): IPrimaryKeyOperation;
  end;

  IPrimaryKeyColumnList = IList<TPrimaryKeyColumn>;

  function CreatePrimaryKeyColumnList: IPrimaryKeyColumnList;

implementation

function CreatePrimaryKeyColumnList: IPrimaryKeyColumnList;
begin
  Result := TCollections.CreateList<TPrimaryKeyColumn>;
end;

end.
