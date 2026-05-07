unit cbsSystem.Database.Persistence;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Database.Persistence,
  cbsSystem.Infrastructure.BaseDbModule,
{SPRING}
  Spring.Persistence.Core.Session;

type
  TPersistence = class(TInterfacedObject, IPersistence)
  private
    FDb: TdamBaseDb;
    FSession: TSession;
    function GetSession: TSession;
  public
    constructor Create(const TDbModule: DbConnectionModuleType);
    destructor Destroy; override;
    property Session: TSession read GetSession;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{SPRING}
  Spring.Persistence.Adapters.FireDAC;

{ TPersistence }

constructor TPersistence.Create(const TDbModule: DbConnectionModuleType);
begin
  inherited Create;
  FDb := TDbModule.Create(nil);
  FSession := TSession.Create(TFireDACConnectionAdapter.Create(FDb.Connection));
end;

destructor TPersistence.Destroy;
begin
  FreeAndNil(FSession);
  FreeAndNil(FDb);
  inherited;
end;

function TPersistence.GetSession: TSession;
begin
  FSession.Connection.Connect;
  Result := FSession;
end;

end.
