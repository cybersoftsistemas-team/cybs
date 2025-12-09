unit cbsSystem.Migrations.DbSystemContext;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Support.MigrationContext;

type
  TDbSystemContext = class(TFDMigrationContext)
  public
    constructor Create;
  end;

implementation

uses
{PROJECT}
  cbsSystem.Support.ServerModule;

{ TDbSystemContext }

constructor TDbSystemContext.Create;
begin
  inherited Create(ServerModule.Database.ConnectionString);
end;

end.
