unit cbsMigrations.Contracts.Migrations.ConnectionResolver;

interface

uses
{IDE}
  Data.DB,
{PROJECT}
  cbsMigrations.Contracts.Schema.Builder,
  cbsMigrations.Contracts.Schema.Grammars.Grammar,
  cbsMigrations.Schema.Types;

type
  IConnectionResolver = interface(IUnknown)
    ['{A23E3D88-6800-409D-B006-4459F91DB2B4}']
    function GetConnection: TCustomConnection;
    function GetDriverID: DriverID;
    function GetSchemaBuilder: IBuilder;
    function GetSchemaGrammar: IGrammar;
    procedure SetConnection(const AValue: TCustomConnection);
    property Connection: TCustomConnection read GetConnection write SetConnection;
    property DriverID: DriverID read GetDriverID;
  end;

implementation

end.
