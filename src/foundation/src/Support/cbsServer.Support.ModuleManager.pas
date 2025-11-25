unit cbsServer.Support.ModuleManager;

interface

uses
{PROJECT}
  cbsServer.Contracts.ModuleManager;

  function ModuleManager: IcbsModuleManager;

implementation

uses
{PROJECT}
  cbsServer.ModuleManager;

var
  InternalModuleManager: IcbsModuleManager;

function ModuleManager: IcbsModuleManager;
begin
  Result := InternalModuleManager;
end;

initialization
begin
  InternalModuleManager := TcbsModuleManager.Create;
end;

finalization
begin
  InternalModuleManager := nil;
end;

end.
