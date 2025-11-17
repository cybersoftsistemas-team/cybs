unit cbsMigrationsFireDac.Migrations.ConnectionResolver;

interface

uses
{IDE}
  FireDAC.DApt,
  FireDAC.Comp.Client,
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommandExecutor,
  cbsMigrations.Contracts.Schema.Builder,
  cbsMigrations.Migrations.ConnectionResolver,
  cbsMigrations.Schema.Types,
  cbsMigrationsFireDac.Contracts.Migrations.ConnectionResolver,
  cbsMigrationsFireDac.Contracts.Migrations.MigrationCommandExecutor;

type
  TFDConnectionResolver = class(TConnectionResolver, IFDConnectionResolver)
  private
    function GetConnection: TFDConnection;
    procedure SetConnection(const AValue: TFDConnection);
  protected
    function CreateInternalCommandExecutor: IMigrationCommandExecutor; override;
    function GetInternalSchemaBuilder: IBuilder; override;
    procedure SetDriverID(var ADriverID: DriverID); override;
  public
    function CreateCommand: TCommand;
    function CreateCommandExecutor: IFDMigrationCommandExecutor;
    property Connection: TFDConnection read GetConnection write SetConnection;
  end;

implementation

uses
{PROJECT}
  cbsMigrations.Support.Schema.Builders,
  cbsMigrationsFireDac.Migrations.MigrationCommandExecutor,
  cbsMigrationsFireDac.Schema.SqlServerBuilder;

{ TFDConnectionResolver }

function TFDConnectionResolver.CreateCommand: TCommand;
begin
  Result := TCommand.Create(nil);
  Result.Connection := Connection;
end;

function TFDConnectionResolver.CreateInternalCommandExecutor: IMigrationCommandExecutor;
begin
  Result := TFDMigrationCommandExecutor.Create(Self);
end;

function TFDConnectionResolver.CreateCommandExecutor: IFDMigrationCommandExecutor;
begin
  Result := TFDMigrationCommandExecutor(inherited CreateCommandExecutor);
end;

function TFDConnectionResolver.GetConnection: TFDConnection;
begin
  Result := TFDConnection(inherited Connection);
end;

function TFDConnectionResolver.GetInternalSchemaBuilder: IBuilder;
begin
  Result := SchemaBuilders[DriverID].Create(Self);
end;

procedure TFDConnectionResolver.SetConnection(const AValue: TFDConnection);
begin
  inherited Connection := AValue;
end;

procedure TFDConnectionResolver.SetDriverID(var ADriverID: DriverID);
begin
  ADriverID := AsDriverID(Connection.Params.DriverID);
end;

initialization
begin
  SchemaBuilders.Add(DriverID.MSSQL, TFDSqlServerBuilder);
end;

end.
