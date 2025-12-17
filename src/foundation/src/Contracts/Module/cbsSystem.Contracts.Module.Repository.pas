unit cbsSystem.Contracts.Module.Repository;

interface

uses
{IDE}
  uniGUIMainModule,
{PROJECT}
  cbsSystem.Module.BaseModule,
{SPRING}
  Spring.Collections;

type
  IModuleTypes = IEnumerable<ModuleType>;
  MainModuleType = TMainModuleClass;
  ModuleType = cbsSystem.Module.BaseModule.ModuleType;

  IModuleTypeRepository = interface(IUnknown)
    ['{45813152-838E-4E5C-943F-22DC39CE0489}']
    function GetModuleTypes: IModuleTypes;
    procedure Register(const AModuleType: ModuleType);
  end;

  IModuleTypeList = IList<ModuleType>;

  function CreateModuleTypeList: IModuleTypeList;

implementation

function CreateModuleTypeList: IModuleTypeList;
begin
  Result := TCollections.CreateList<ModuleType>;
end;

end.
