unit cbsSystem.Contracts.Database.Seeders.DatabaseSeederTypeRepository;

interface

uses
{PROJECT}
  cbsSystem.Database.Seeders.DatabaseSeeder,
{SPRING}
  Spring.Collections;

type
  TDatabaseSeederTypeItem = TPair<string, DatabaseSeederType>;

  IDatabaseSeederTypeEnumerator = IEnumerator<DatabaseSeederType>;
  IDatabaseSeederTypes = IEnumerable<TDatabaseSeederTypeItem>;

  IDatabaseSeederTypeRepository = interface(IUnknown)
    ['{8380E28B-53DF-423B-8F93-36AFABBD786D}']
    function GetEnumerator: IDatabaseSeederTypeEnumerator;
    procedure Register(const ADatabaseSeederType: DatabaseSeederType);
  end;

  IDatabaseSeederTypeList = IOrderedDictionary<string, DatabaseSeederType>;

  function CreateDatabaseSeederTypeList(const ADatabaseSeederTypes: IDatabaseSeederTypes = nil): IDatabaseSeederTypeList;

implementation

function CreateDatabaseSeederTypeList(const ADatabaseSeederTypes: IDatabaseSeederTypes = nil): IDatabaseSeederTypeList;
begin
  Result := TCollections.CreateDictionary<string, DatabaseSeederType>;
  if Assigned(ADatabaseSeederTypes) then
  begin
    Result.AddRange(ADatabaseSeederTypes);
  end;
end;

end.
