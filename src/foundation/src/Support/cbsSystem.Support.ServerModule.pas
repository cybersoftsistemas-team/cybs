unit cbsSystem.Support.ServerModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.ServerModule;

  function ServerModule: IServerModule;
  procedure RegisterInternalSystemServerModule(const AServerModule: IServerModule);

implementation

var
  InternalServerModule: IServerModule;

function ServerModule: IServerModule;
begin
  Result := InternalServerModule;
end;

procedure RegisterInternalSystemServerModule(const AServerModule: IServerModule);
begin
  InternalServerModule := AServerModule;
end;

end.
