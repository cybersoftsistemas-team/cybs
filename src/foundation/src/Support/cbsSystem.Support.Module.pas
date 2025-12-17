unit cbsSystem.Support.Module;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Repository,
  cbsSystem.Module.BaseModule;

  procedure RegisterModuleType(const AModuleType: ModuleType);

implementation

uses
{PROJECT}
  cbsSystem.Support.ModuleTypeRepository;

procedure RegisterModuleType(const AModuleType: ModuleType);
begin
  ModuleTypeRepository.Register(AModuleType);
end;

end.
