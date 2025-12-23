unit cbsSystem.Database.Seeders.DatabaseSeederTypeRepository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Database.Seeders.DatabaseSeederTypeRepository,
  cbsSystem.Database.Seeders.DatabaseSeeder;

type
  TcbsDatabaseSeederTypeRepository = class(TInterfacedObject, IDatabaseSeederTypeRepository)
  private
    FDatabaseSeederTypeList: IDatabaseSeederTypeList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetEnumerator: IDatabaseSeederTypeEnumerator;
    procedure Register(const ADatabaseSeederType: DatabaseSeederType);
  end;

implementation

{ TcbsDatabaseSeederTypeRepository }

constructor TcbsDatabaseSeederTypeRepository.Create;
begin
  inherited Create;
  FDatabaseSeederTypeList := CreateDatabaseSeederTypeList;
end;

destructor TcbsDatabaseSeederTypeRepository.Destroy;
begin
  FDatabaseSeederTypeList := nil;
  inherited;
end;

function TcbsDatabaseSeederTypeRepository.GetEnumerator: IDatabaseSeederTypeEnumerator;
begin
  var LOrderedDatabaseSeederTypes :=
    CreateDatabaseSeederTypeList(FDatabaseSeederTypeList.Ordered);
  FDatabaseSeederTypeList.Clear;
  FDatabaseSeederTypeList.AddRange(LOrderedDatabaseSeederTypes);
  Result := FDatabaseSeederTypeList.Values.GetEnumerator;
end;

procedure TcbsDatabaseSeederTypeRepository.Register(const ADatabaseSeederType: DatabaseSeederType);
begin
  if not FDatabaseSeederTypeList.ContainsKey(ADatabaseSeederType.UnitName) then
  begin
    FDatabaseSeederTypeList[ADatabaseSeederType.UnitName] := ADatabaseSeederType;
  end;
end;

end.
