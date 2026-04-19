unit cbsMigrations.Migrations.Operations.IncludeColumn;

interface

uses
{SPRING}
  Spring.Collections;

type
  TDescending = array of Boolean;
  TIncludeColumn = string;
  TIndexColumn = TIncludeColumn;

  IIncludeColumns = IEnumerable<TIncludeColumn>;
  IIndexColumns = IEnumerable<TIndexColumn>;

  IIncludeColumnList = IList<TIncludeColumn>;
  IIndexColumnList = IList<TIndexColumn>;

  function CreateIncludeColumnList: IIncludeColumnList;
  function CreateIndexColumnList: IIndexColumnList;

implementation

function CreateIncludeColumnList: IIncludeColumnList;
begin
  Result := TCollections.CreateList<TIncludeColumn>;
end;

function CreateIndexColumnList: IIndexColumnList;
begin
  Result := TCollections.CreateList<TIndexColumn>;
end;

end.
