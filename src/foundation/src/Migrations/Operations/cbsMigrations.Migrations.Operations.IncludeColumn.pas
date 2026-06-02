unit cbsMigrations.Migrations.Operations.IncludeColumn;

interface

uses
{SPRING}
  Spring.Collections;

type
  TDescending = array of Boolean;
  TIncludeColumn = string;
  TFilterColumn = TIncludeColumn;
  TIndexColumn = TIncludeColumn;

  IFilterColumns = IEnumerable<TFilterColumn>;
  IIndexColumns = IEnumerable<TIndexColumn>;
  IIncludeColumns = IEnumerable<TIncludeColumn>;

  IFilterColumnList = IList<TFilterColumn>;
  IIndexColumnList = IList<TIndexColumn>;
  IIncludeColumnList = IList<TIncludeColumn>;

  function CreateFilterColumnList: IFilterColumnList;
  function CreateIndexColumnList: IIndexColumnList;
  function CreateIncludeColumnList: IIncludeColumnList;

implementation

function CreateFilterColumnList: IFilterColumnList;
begin
  Result := TCollections.CreateList<TFilterColumn>;
end;

function CreateIndexColumnList: IIndexColumnList;
begin
  Result := TCollections.CreateList<TIndexColumn>;
end;

function CreateIncludeColumnList: IIncludeColumnList;
begin
  Result := TCollections.CreateList<TIncludeColumn>;
end;

end.
