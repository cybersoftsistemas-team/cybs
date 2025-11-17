unit cbsMigrationsFireDac.Migrations.MigrationContextBase;

interface

uses
{IDE}
  FireDAC.Comp.Client,
{PROJECT}
  cbsMigrations.Contracts.Migrations.ConnectionResolver,
  cbsMigrations.Contracts.Migrations.DatabaseMigrationRepository,
  cbsMigrations.Migrations.MigrationContext,
  cbsMigrationsFireDac.Contracts.Migrations.ConnectionResolver,
  cbsMigrationsFireDac.Contracts.Migrations.MigrationContextBase;

type
  TFDMigrationContextBase = class(TMigrationContext, IFDMigrationContextBase)
  private
    function GetConnection: TFDConnection;
    function GetResolver: IFDConnectionResolver;
    procedure SetConnection(const AValue: TFDConnection);
  protected
    function CreateRepository: IDatabaseMigrationRepository; override;
    function CreateResolver: IConnectionResolver; override;
    property Resolver: IFDConnectionResolver read GetResolver;
  public
    property Connection: TFDConnection read GetConnection write SetConnection;
  end;

implementation

uses
{PROJECT}
  cbsMigrationsFireDac.Migrations.ConnectionResolver,
  cbsMigrationsFireDac.Migrations.DatabaseMigrationRepository;

{ TFDMigrationContextBase }

function TFDMigrationContextBase.CreateRepository: IDatabaseMigrationRepository;
begin
  Result := TFDDatabaseMigrationRepository.Create(Resolver);
end;

function TFDMigrationContextBase.CreateResolver: IConnectionResolver;
begin
  Result := TFDConnectionResolver.Create;
end;

function TFDMigrationContextBase.GetConnection: TFDConnection;
begin
  Result := TFDConnection(inherited Connection);
end;

function TFDMigrationContextBase.GetResolver: IFDConnectionResolver;
begin
  Result := TFDConnectionResolver(inherited Resolver);
end;

procedure TFDMigrationContextBase.SetConnection(const AValue: TFDConnection);
begin
  inherited Connection := AValue;
end;

end.
