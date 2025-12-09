unit cbsSystem.Support.Module;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule;

  procedure RegisterModuleType(const AModuleType: ModuleType);

implementation

uses
{PROJECT}
  cbsSystem.Exprts.ModuleTypeRepository;

procedure RegisterModuleType(const AModuleType: ModuleType);
begin
  ModuleTypeRepository.Register(AModuleType);
end;

end.
