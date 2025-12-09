unit cbsSystem.Contracts.Module.Manager;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module,
{SPRING}
  Spring.Collections;

type
  IModuleEnumerator = IEnumerator<IModule>;

  IModuleManager = interface(IUnknown)
    ['{85218BA3-575A-40CE-9192-FF6F2CE04C9D}']
    function GetEnumerator: IModuleEnumerator;
    procedure LoadFromFolder(const AFolder: string);
  end;

  IModuleList = IList<IModule>;

  function CreateModuleList: IModuleList;

implementation

function CreateModuleList: IModuleList;
begin
  Result := TCollections.CreateInterfaceList<IModule>;
end;

end.
