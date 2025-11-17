unit cbsMigrations.Migrations.ConnectionResolver;

interface

uses
{IDE}
  Data.DB,
{PROJECT}
  cbsMigrations.Contracts.Migrations.ConnectionResolver,
  cbsMigrations.Contracts.Migrations.MigrationCommandExecutor,
  cbsMigrations.Contracts.Schema.Builder,
  cbsMigrations.Contracts.Schema.Grammars.Grammar,
  cbsMigrations.Schema.Types;

type
  TConnectionResolver = class abstract(TInterfacedObject, IConnectionResolver)
  private
    FConnection: TCustomConnection;
    FDriverID: DriverID;
    function GetConnection: TCustomConnection;
    function GetDriverID: DriverID;
    procedure SetConnection(const AValue: TCustomConnection);
    procedure SetDriverID; overload;
  protected
    function CreateInternalCommandExecutor: IMigrationCommandExecutor; virtual; abstract;
    function GetInternalSchemaBuilder: IBuilder; virtual; abstract;
    procedure SetDriverID(var ADriverID: DriverID); overload; virtual; abstract;
  public
    function CreateCommandExecutor: IMigrationCommandExecutor;
    function GetSchemaBuilder: IBuilder;
    function GetSchemaGrammar: IGrammar;
    property Connection: TCustomConnection read GetConnection write SetConnection;
    property DriverID: DriverID read GetDriverID;
  end;

implementation

{ TConnectionResolver }

function TConnectionResolver.CreateCommandExecutor: IMigrationCommandExecutor;
begin
  Result := CreateInternalCommandExecutor;
end;

function TConnectionResolver.GetConnection: TCustomConnection;
begin
  Result := FConnection;
end;

function TConnectionResolver.GetDriverID: DriverID;
begin
  Result := FDriverID;
end;

function TConnectionResolver.GetSchemaBuilder: IBuilder;
begin
  Result := GetInternalSchemaBuilder;
end;

function TConnectionResolver.GetSchemaGrammar: IGrammar;
begin
  Result := GetSchemaBuilder.Grammar;
end;

procedure TConnectionResolver.SetConnection(const AValue: TCustomConnection);
begin
  FConnection := AValue;
  SetDriverID;
end;

procedure TConnectionResolver.SetDriverID;
var
  LDriverID: cbsMigrations.Schema.Types.DriverID;
begin
  SetDriverID(LDriverID);
  FDriverID := LDriverID;
end;

end.
