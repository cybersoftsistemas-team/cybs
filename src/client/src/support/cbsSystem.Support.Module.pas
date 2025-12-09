unit cbsSystem.Support.Module;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule;

  procedure RegisterModuleType(const AModuleType: ModuleType);

implementation

uses
{PROJECT}
  cbsSystem.Support.Module.Repository;

procedure RegisterModuleType(const AModuleType: ModuleType);
begin
  ModuleTypeRepository.Register(AModuleType);
end;

end.
