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
    procedure SetConnection(const AValue: TFDConnection);
    property Connection: TFDConnection read GetConnection write SetConnection;
  end;

implementation

end.
