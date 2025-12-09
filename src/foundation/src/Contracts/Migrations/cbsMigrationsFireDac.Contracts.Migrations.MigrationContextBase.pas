unit cbsMigrationsFireDac.Contracts.Migrations.MigrationContextBase;

interface

uses
{IDE}
  FireDAC.Comp.Client,
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationContext;

type
  IFDMigrationContextBase = interface(IMigrationContext)
    ['{C072263C-5956-4301-9398-FB4C0E95ACBB}']
    function GetConnection: TFDConnection;
    function GetConnectionString: string;
    procedure SetConnection(const AValue: TFDConnection);
    procedure SetConnectionString(const AValue: string);
    property Connection: TFDConnection read GetConnection write SetConnection;
    property ConnectionString: string read GetConnectionString write SetConnectionString;
  end;

implementation

end.
