unit cbsSystem.Contracts.Module;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.Repository,
  cbsSystem.Contracts.Module.Repository,
{SPRING}
  Spring.Collections;

type
  IRequires = IEnumerable<string>;

  IModule = interface(IUnknown)
    ['{2AEF67FF-A8C4-453C-94DF-2DF79274C1B5}']
    function FormTypes: IFormTypes;
    function GetHandle: HMODULE;
    function GetName: string;
    function GetRequires: IRequires;
    function ModuleTypes: IModuleTypes;
    procedure ExecuteMigrations;
    property Handle: HMODULE read GetHandle;
    property Name: string read GetName;
    property Requires: IRequires read GetRequires;
  end;

  IRequiredList = IList<string>;

  function CreateRequiredList: IRequiredList;

implementation

function CreateRequiredList: IRequiredList;
begin
  Result := TCollections.CreateList<string>;
end;

end.
