unit cbsServer.Contracts.Registered.Modules;

interface

uses
{PROJECT}
  cbsServer.Cybersoft.BaseModule,
{SPRING}
  Spring.Collections;

type
  IcbsRegisteredModules = interface(IUnknown)
    ['{45813152-838E-4E5C-943F-22DC39CE0489}']
    function ToArray: TArray<TcbsModuleClass>;
    procedure Add(const AModuleClass: TcbsModuleClass);
  end;

  IModuleClassList = IList<TcbsModuleClass>;

  function CreateModuleClassList: IModuleClassList;

implementation

function CreateModuleClassList: IModuleClassList;
begin
  Result := TCollections.CreateList<TcbsModuleClass>;
end;

end.
