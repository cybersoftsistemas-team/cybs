unit cbsMigrationsFireDac.Migrations.DatabaseMigrationRepository;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Contracts.Migrations.ConnectionResolver,
  cbsMigrationsFireDac.Contracts.Migrations.DatabaseMigrationRepository,
  cbsMigrations.Migrations.DatabaseMigrationRepository;

type
  TFDDatabaseMigrationRepository = class(TDatabaseMigrationRepository, IFDDatabaseMigrationRepository)
  private
    function GetResolver: IFDConnectionResolver;
  protected
    function GetInternalRan: TArray<TMigrationName>; override;
    procedure CreateInternalIfNotExists; override;
    procedure RunInternalPending(const AMigrationTypes: TArray<TClass>); override;
    property Resolver: IFDConnectionResolver read GetResolver;
  public
    constructor Create(const AResolver: IFDConnectionResolver);
  end;

implementation

uses
{PROJECT}
  cbsMigrationsFireDac.Migrations.ConnectionResolver;

{ TFDDatabaseMigrationRepository }

constructor TFDDatabaseMigrationRepository.Create(const AResolver: IFDConnectionResolver);
begin
  inherited Create(AResolver);
end;

function TFDDatabaseMigrationRepository.GetResolver: IFDConnectionResolver;
begin
  Result := TFDConnectionResolver(inherited Resolver);
end;

procedure TFDDatabaseMigrationRepository.RunInternalPending(const AMigrationTypes: TArray<TClass>);
begin
  Resolver.GetSchemaBuilder.RunPending(AMigrationTypes, Table);
end;

procedure TFDDatabaseMigrationRepository.CreateInternalIfNotExists;
begin
  Resolver.GetSchemaBuilder.CreateIfNotExists(Table);
end;

function TFDDatabaseMigrationRepository.GetInternalRan: TArray<TMigrationName>;
begin
  Result := Resolver.GetSchemaBuilder.GetRan(Table);
end;

end.
