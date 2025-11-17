unit cbsMigrations.Contracts.Migrations.MigrationContext;

interface

uses
{IDE}
  Data.DB,
  System.SysUtils,
{SPRING}
  Spring.Collections;

type
  TMigrationTypeItem = TPair<string, TClass>;
  TMigrationTypeList = IOrderedDictionary<string, TClass>;

  IMigrationTypes = IEnumerable<TMigrationTypeItem>;

  IMigrationContext = interface(IUnknown)
    ['{9C93F551-6B0D-442E-A303-4FD9AF0AA0A2}']
    function GetConnection: TCustomConnection;
    function GetRepositoryPrefix: string;
    procedure SetConnection(const AValue: TCustomConnection);
    procedure SetRepositoryPrefix(const AValue: string);
    procedure UpdateDatabase(const ASeed: TProc = nil);
    property Connection: TCustomConnection read GetConnection write SetConnection;
    property RepositoryPrefix: string read GetRepositoryPrefix write SetRepositoryPrefix;
  end;

  IRanSet = ISet<string>;

  function CreateRanSet(const AElements: TArray<string>): IRanSet;
  function CreateMigrationTypeList(const AMigrationTypes: IMigrationTypes = nil): TMigrationTypeList;

implementation

function CreateRanSet(const AElements: TArray<string>): IRanSet;
begin
  Result := TCollections.CreateSet<string>(AElements);
end;

function CreateMigrationTypeList(const AMigrationTypes: IMigrationTypes): TMigrationTypeList;
begin
  Result := TCollections.CreateDictionary<string, TClass>;
  if Assigned(AMigrationTypes) then
  begin
    Result.AddRange(AMigrationTypes);
  end;
end;

end.
