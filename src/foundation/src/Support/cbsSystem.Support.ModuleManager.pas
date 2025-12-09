unit cbsSystem.Support.ModuleManager;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Manager;

  function ModuleManager: IModuleManager;

implementation

uses
{PROJECT}
  cbsSystem.Module.Manager;

var
  InternalModuleManager: IModuleManager;

function ModuleManager: IModuleManager;
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
