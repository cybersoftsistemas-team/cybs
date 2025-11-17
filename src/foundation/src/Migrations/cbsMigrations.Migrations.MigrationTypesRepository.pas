unit cbsMigrations.Migrations.MigrationTypesRepository;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationTypesRepository,
  cbsMigrations.Migrations.MigrationContext,
  cbsMigrations.Migrations.MigrationTypes;

type
  TMigrationTypesRepository = class(TInterfacedObject, IMigrationTypesRepository)
  private
    FMigrationContextTypeList: IMigrationContextTypeList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetMigrationTypes(const AMigrationContext: TMigrationContext): IMigrationTypes;
    procedure Register(const AMigrationContextType: MigrationContextType; const AMigrationTypes: MigrationTypes);
  end;

implementation

{ TMigrationTypesRepository }

constructor TMigrationTypesRepository.Create;
begin
  inherited Create;
  FMigrationContextTypeList := CreateMigrationContextTypeList;
end;

destructor TMigrationTypesRepository.Destroy;
begin
  FMigrationContextTypeList.Clear;
  FMigrationContextTypeList := nil;
  inherited;
end;

function TMigrationTypesRepository.GetMigrationTypes(const AMigrationContext: TMigrationContext): IMigrationTypes;
begin
  if FMigrationContextTypeList.ContainsKey(AMigrationContext.ClassInfo) then
  begin
    Exit(FMigrationContextTypeList[AMigrationContext.ClassInfo]);
  end;
  Result := CreateMigrationTypeList;
end;

procedure TMigrationTypesRepository.Register(const AMigrationContextType: MigrationContextType; const AMigrationTypes: MigrationTypes);
var
  LMigrationTypeList: IMigrationTypeList;
begin
  if not FMigrationContextTypeList.TryGetValue(AMigrationContextType.ClassInfo, LMigrationTypeList) then
  begin
    LMigrationTypeList := CreateMigrationTypeList;
  end;
  for var LMigrationType in AMigrationTypes do if
    not LMigrationTypeList.Contains(LMigrationType) then
  begin
    LMigrationTypeList.Add(LMigrationType);
  end;
  FMigrationContextTypeList[AMigrationContextType.ClassInfo] := LMigrationTypeList;
end;

end.
