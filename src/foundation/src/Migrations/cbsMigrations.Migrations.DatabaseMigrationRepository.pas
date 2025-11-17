unit cbsMigrations.Migrations.DatabaseMigrationRepository;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.ConnectionResolver,
  cbsMigrations.Contracts.Migrations.DatabaseMigrationRepository;

type
  TDatabaseMigrationRepository = class abstract(TInterfacedObject, IDatabaseMigrationRepository)
  private
    FResolver: IConnectionResolver;
    FTable: string;
    function GetTable: string;
    procedure SetTable(const AValue: string);
  protected
    function GetInternalRan: TArray<TMigrationName>; virtual; abstract;
    procedure CreateInternalIfNotExists; virtual; abstract;
    procedure RunInternalPending(const AMigrationType: TArray<TClass>); virtual; abstract;
    property Resolver: IConnectionResolver read FResolver;
  public
    constructor Create(const AResolver: IConnectionResolver);
    destructor Destroy; override;
    function GetRan: TArray<TMigrationName>;
    procedure CreateIfNotExists;
    procedure RunPending(const AMigrationType: TArray<TClass>);
    property Table: string read GetTable write SetTable;
  end;

implementation

{ TDatabaseMigrationRepository }

constructor TDatabaseMigrationRepository.Create(const AResolver: IConnectionResolver);
begin
  inherited Create;
  FResolver := AResolver;
end;

destructor TDatabaseMigrationRepository.Destroy;
begin
  FTable := '';
  FResolver := nil;
  inherited;
end;

function TDatabaseMigrationRepository.GetRan: TArray<TMigrationName>;
begin
  Result := GetInternalRan;
end;

function TDatabaseMigrationRepository.GetTable: string;
begin
  Result := FTable;
end;

procedure TDatabaseMigrationRepository.RunPending(const AMigrationType: TArray<TClass>);
begin
  RunInternalPending(AMigrationType);
end;

procedure TDatabaseMigrationRepository.CreateIfNotExists;
begin
  CreateInternalIfNotExists;
end;

procedure TDatabaseMigrationRepository.SetTable(const AValue: string);
begin
  FTable := AValue;
end;

end.
