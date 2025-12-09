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
    function GetConnectionString: string;
    function GetResolver: IFDConnectionResolver;
    procedure SetConnection(const AValue: TFDConnection);
    procedure SetConnectionString(const AValue: string);
  protected
    function CreateRepository: IDatabaseMigrationRepository; override;
    function CreateResolver: IConnectionResolver; override;
    property Resolver: IFDConnectionResolver read GetResolver;
  public
    constructor Create(const AConnectionString: string); overload;
    property Connection: TFDConnection read GetConnection write SetConnection;
    property ConnectionString: string read GetConnectionString write SetConnectionString;
  end;

  MigrationContextType = class of TFDMigrationContextBase;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMigrationsFireDac.Migrations.ConnectionResolver,
  cbsMigrationsFireDac.Migrations.DatabaseMigrationRepository;

{ TFDMigrationContextBase }

constructor TFDMigrationContextBase.Create(const AConnectionString: string);
begin
  inherited Create;
  SetConnectionString(AConnectionString);
end;

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

function TFDMigrationContextBase.GetConnectionString: string;
begin
  Result := TFDConnection(inherited Connection).ConnectionString;
end;

function TFDMigrationContextBase.GetResolver: IFDConnectionResolver;
begin
  Result := TFDConnectionResolver(inherited Resolver);
end;

procedure TFDMigrationContextBase.SetConnection(const AValue: TFDConnection);
begin
  inherited Connection := AValue;
  SetOwnsConnection(False);
end;

procedure TFDMigrationContextBase.SetConnectionString(const AValue: string);
begin
  var LConnection: TFDConnection := nil;
  if not AValue.Trim.IsEmpty then
  begin
    LConnection := TFDConnection.Create(nil);
    LConnection.ConnectionString := AValue;
  end;
  inherited Connection := LConnection;
  SetOwnsConnection;
end;

end.
