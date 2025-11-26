unit cbsCServer.Support.ModuleManager;

interface

uses
{PROJECT}
  cbsCServer.Contracts.Module.Manager;

  function ModuleManager: IcbsModuleManager;

implementation

uses
{PROJECT}
  cbsCServer.Module.Manager;

var
  GModuleManager: IcbsModuleManager;

function ModuleManager: IcbsModuleManager;
begin
  Result := GModuleManager;
end;

initialization
begin
  GModuleManager := TcbsModuleManager.Create;
end;

finalization
begin
  GModuleManager := nil;
end;

end.
