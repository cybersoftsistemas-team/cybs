unit cbsMigrations.Migrations.MigrationContext;

interface

uses
{IDE}
  Data.DB,
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.ConnectionResolver,
  cbsMigrations.Contracts.Migrations.DatabaseMigrationRepository,
  cbsMigrations.Contracts.Migrations.MigrationContext;

type
  TMigrationContext = class abstract(TInterfacedObject, IMigrationContext)
  private
    FConnection: TCustomConnection;
    FMigrationTypeList: TMigrationTypeList;
    FOwnsConnection: Boolean;
    FRepository: IDatabaseMigrationRepository;
    FRepositoryPrefix: string;
    FResolver: IConnectionResolver;
    function GetConnection: TCustomConnection;
    function GetRepositoryName: string;
    function GetRepositoryPrefix: string;
    procedure GetDeclaredMigrationTypes;
    procedure RejectMigrationTypes(const ARan: TArray<string>);
    procedure SetConnection(const AValue: TCustomConnection);
    procedure SetRepositoryPrefix(const AValue: string);
    procedure SortMigrationTypes;
  protected
    const
      RepositoryNameDef = 'migrations';
      RepositoryPrefixDef = '';
      RepositorySchema = 'dbo';
    function CreateRepository: IDatabaseMigrationRepository; virtual; abstract;
    function CreateResolver: IConnectionResolver; virtual; abstract;
    procedure DoUpdateDatabase; virtual;
    procedure SetOwnsConnection(const AValue: Boolean = True);
    property Resolver: IConnectionResolver read FResolver;
  public
    constructor Create;
    destructor Destroy; override;
    procedure UpdateDatabase(const ASeed: TProc = nil);
    property Connection: TCustomConnection read GetConnection write SetConnection;
    property RepositoryPrefix: string read GetRepositoryPrefix write SetRepositoryPrefix;
  end;

  MigrationContextType = class of TMigrationContext;

implementation

uses
{PROJECT}
  cbsMigrations.Support.Migration,
  cbsMigrations.Support.MigrationTypesRepository;

{ TMigrationContext }

constructor TMigrationContext.Create;
begin
  inherited Create;
  FMigrationTypeList := CreateMigrationTypeList;
end;

destructor TMigrationContext.Destroy;
begin
  FMigrationTypeList.Clear;
  FRepository := nil;
  FResolver := nil;
  FMigrationTypeList := nil;
  if FOwnsConnection then
  begin
    FreeAndNil(FConnection);
  end;
  inherited;
end;

procedure TMigrationContext.DoUpdateDatabase;
begin
  GetDeclaredMigrationTypes;
  FRepository.Schema := RepositorySchema;
  FRepository.Table := GetRepositoryName;
  FRepository.CreateIfNotExists;
  RejectMigrationTypes(FRepository.GetRan);
  FRepository.RunPending(FMigrationTypeList.Values.ToArray);
end;

function TMigrationContext.GetConnection: TCustomConnection;
begin
  Result := FConnection;
end;

procedure TMigrationContext.GetDeclaredMigrationTypes;
begin
  FMigrationTypeList.Clear;
  MigrationTypesRepository
   .GetMigrationTypes(Self).ForEach(
    procedure(const AMigrationType: MigrationType)
    begin
      FMigrationTypeList.Add(AMigrationType.UnitName, AMigrationType);
    end);
  SortMigrationTypes;
end;

function TMigrationContext.GetRepositoryName: string;
begin
  Result := Format(RepositoryNameDef, [RepositoryPrefix]);
end;

function TMigrationContext.GetRepositoryPrefix: string;
begin
  if FRepositoryPrefix.Trim.IsEmpty then
  begin
    Exit(RepositoryPrefixDef);
  end;
  Result := FRepositoryPrefix;
end;

procedure TMigrationContext.RejectMigrationTypes(const ARan: TArray<string>);
var
  LRanSet: IRanSet;
begin
  LRanSet := CreateRanSet(ARan);
  FMigrationTypeList.RemoveAll(
    function(const AMigrationTypeItem: TMigrationTypeItem): Boolean
    begin
      Result := LRanSet.Contains(AMigrationTypeItem.Key);
    end);
end;

procedure TMigrationContext.SetConnection(const AValue: TCustomConnection);
begin
  if FOwnsConnection then
  begin
    FreeAndNil(FConnection);
  end;
  FConnection := AValue;
  FResolver := CreateResolver;
  FResolver.Connection := AValue;
  FRepository := CreateRepository;
end;

procedure TMigrationContext.SetOwnsConnection(const AValue: Boolean);
begin
  FOwnsConnection := AValue;
end;

procedure TMigrationContext.SetRepositoryPrefix(const AValue: string);
begin
  FRepositoryPrefix := AValue;
end;

procedure TMigrationContext.SortMigrationTypes;
begin
  var LOrderedMigrationTypes :=
    CreateMigrationTypeList(FMigrationTypeList.Ordered);
  FMigrationTypeList.Clear;
  FMigrationTypeList.AddRange(LOrderedMigrationTypes);
end;

procedure TMigrationContext.UpdateDatabase(const ASeed: TProc);
begin
  DoUpdateDatabase;
  if Assigned(ASeed) then
  begin
    ASeed;
  end;
end;

end.
