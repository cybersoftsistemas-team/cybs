unit cbsMigrationsFireDac.Contracts.Migrations.ConnectionResolver;

interface

uses
{IDE}
  FireDAC.Comp.Client,
{PROJECT}
  cbsMigrations.Contracts.Migrations.ConnectionResolver,
  cbsMigrationsFireDac.Contracts.Migrations.MigrationCommandExecutor;

type
  TCommand = TFDQuery;

  IFDConnectionResolver = interface(IConnectionResolver)
    ['{6BC7334E-6783-480B-B7CC-5CED4F1F2085}']
    function CreateCommand: TCommand;
    function CreateCommandExecutor: IFDMigrationCommandExecutor;
    function GetConnection: TFDConnection;
    procedure SetConnection(const AValue: TFDConnection);
    property Connection: TFDConnection read GetConnection write SetConnection;
  end;

implementation

end.
