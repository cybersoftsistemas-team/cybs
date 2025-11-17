unit cbsMigrations.Contracts.Migrations.Operations.UniqueConstraintOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
{SPRING}
  Spring.Collections;

type
  TUniqueColumn = string;
  IUniqueColumns = IEnumerable<TUniqueColumn>;

  IUniqueConstraintOperation = interface(IConstraintOperation)
    ['{19435A90-4BB8-4668-9BD6-498F3D7B3B5B}']
    function Columns: IUniqueColumns;
    function HasColumns(const AColumns: array of TUniqueColumn): IUniqueConstraintOperation;
    function HasSchema(const ASchema: string): IUniqueConstraintOperation;
    function HasTable(const ATable: string): IUniqueConstraintOperation;
  end;

  IUniqueColumnList = IList<TUniqueColumn>;

  function CreateUniqueColumnList: IUniqueColumnList;

implementation

function CreateUniqueColumnList: IUniqueColumnList;
begin
  Result := TCollections.CreateList<TUniqueColumn>;
end;


end.
