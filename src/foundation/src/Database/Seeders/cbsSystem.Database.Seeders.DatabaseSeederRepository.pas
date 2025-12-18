unit cbsSystem.Database.Seeders.DatabaseSeederRepository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Database.Seeders.DatabaseSeederRepository,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TcbsDatabaseSeederRepository = class(TInterfacedObject, IDatabaseSeederRepository)
  private
    FDatabaseSeederTypeList: IDatabaseSeederTypeList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetEnumerator: IDatabaseSeederEnumerator;
    procedure Register(const ADatabaseSeederType: DatabaseSeederType);
  end;

implementation

{ TcbsDatabaseSeederRepository }

constructor TcbsDatabaseSeederRepository.Create;
begin
  inherited Create;
  FDatabaseSeederTypeList := CreateDatabaseSeederTypeList;
end;

destructor TcbsDatabaseSeederRepository.Destroy;
begin
  FDatabaseSeederTypeList := nil;
  inherited;
end;

function TcbsDatabaseSeederRepository.GetEnumerator: IDatabaseSeederEnumerator;
begin
  var LOrderedDatabaseSeederTypes :=
    CreateDatabaseSeederTypeList(FDatabaseSeederTypeList.Ordered);
  FDatabaseSeederTypeList.Clear;
  FDatabaseSeederTypeList.AddRange(LOrderedDatabaseSeederTypes);
  Result := FDatabaseSeederTypeList.Values.GetEnumerator;
end;

procedure TcbsDatabaseSeederRepository.Register(const ADatabaseSeederType: DatabaseSeederType);
begin
  if not FDatabaseSeederTypeList.ContainsKey(ADatabaseSeederType.UnitName) then
  begin
    FDatabaseSeederTypeList[ADatabaseSeederType.UnitName] := ADatabaseSeederType;
  end;
end;

end.
