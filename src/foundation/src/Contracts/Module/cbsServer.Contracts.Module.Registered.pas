unit cbsServer.Contracts.Module.Registered;

interface

uses
{PROJECT}
  cbsServer.Module.BaseModule,
{SPRING}
  Spring.Collections;

type
  IcbsModuleRegistered = interface(IUnknown)
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
