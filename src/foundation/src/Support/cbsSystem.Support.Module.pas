unit cbsSystem.Support.Module;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Repository,
  cbsSystem.Module.BaseModule;

  procedure RegisterMainModuleType(const AMainModuleType: MainModuleType);
  procedure RegisterModuleType(const AModuleType: ModuleType);

implementation

uses
{PROJECT}
  cbsSystem.Support.ModuleTypeRepository;

procedure RegisterMainModuleType(const AMainModuleType: MainModuleType);
begin
  ModuleTypeRepository.RegisterMain(AMainModuleType);
end;

procedure RegisterModuleType(const AModuleType: ModuleType);
begin
  ModuleTypeRepository.Register(AModuleType);
end;

end.
