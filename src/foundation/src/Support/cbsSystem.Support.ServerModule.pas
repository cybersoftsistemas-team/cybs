unit cbsSystem.Support.ServerModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.ServerModule;

var
  ServerModule: IServerModule = nil;

procedure RegisterSystemServerModule(const AServerModule: IServerModule);

implementation

procedure RegisterSystemServerModule(const AServerModule: IServerModule);
begin
  ServerModule := AServerModule;
end;

end.
