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
    FSchema: string;
    FTable: string;
    function GetSchema: string;
    function GetTable: string;
    procedure SetSchema(const AValue: string);
    procedure SetTable(const AValue: string);
  protected
    procedure CreateInternalIfNotExists; virtual; abstract;
    function GetInternalRan: TArray<TMigrationName>; virtual; abstract;
    procedure RunInternalPending(const AMigrationType: TArray<TClass>); virtual; abstract;
    property Resolver: IConnectionResolver read FResolver;
  public
    constructor Create(const AResolver: IConnectionResolver);
    destructor Destroy; override;
    procedure CreateIfNotExists;
    function GetRan: TArray<TMigrationName>;
    procedure RunPending(const AMigrationType: TArray<TClass>);
    property Schema: string read GetSchema write SetSchema;
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

procedure TDatabaseMigrationRepository.CreateIfNotExists;
begin
  CreateInternalIfNotExists;
end;

function TDatabaseMigrationRepository.GetRan: TArray<TMigrationName>;
begin
  Result := GetInternalRan;
end;

function TDatabaseMigrationRepository.GetSchema: string;
begin
  Result := FSchema;
end;

function TDatabaseMigrationRepository.GetTable: string;
begin
  Result := FTable;
end;

procedure TDatabaseMigrationRepository.RunPending(const AMigrationType: TArray<TClass>);
begin
  RunInternalPending(AMigrationType);
end;

procedure TDatabaseMigrationRepository.SetSchema(const AValue: string);
begin
  FSchema := AValue;
end;

procedure TDatabaseMigrationRepository.SetTable(const AValue: string);
begin
  FTable := AValue;
end;

end.
