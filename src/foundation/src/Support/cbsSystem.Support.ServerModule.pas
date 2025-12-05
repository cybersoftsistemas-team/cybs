unit cbsSystem.Support.ServerModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.ServerModule;

var
  ServerModule: IServerModule = nil;

  procedure RegisterInternalSystemServerModule(const AServerModule: IServerModule);

implementation

procedure RegisterInternalSystemServerModule(const AServerModule: IServerModule);
begin
  ServerModule := AServerModule;
end;

end.
