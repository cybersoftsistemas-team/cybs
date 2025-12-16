unit cbsSystem.Support.Module;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule;

  procedure RegisterMainModuleType(const AModuleType: ModuleType);
  procedure RegisterModuleType(const AModuleType: ModuleType);

implementation

uses
{PROJECT}
  cbsSystem.Support.ModuleTypeRepository;

procedure RegisterMainModuleType(const AModuleType: ModuleType);
begin
  ModuleTypeRepository.RegisterMain(AModuleType);
end;

procedure RegisterModuleType(const AModuleType: ModuleType);
begin
  ModuleTypeRepository.Register(AModuleType);
end;

end.
