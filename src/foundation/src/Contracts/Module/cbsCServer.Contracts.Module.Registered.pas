unit cbsCServer.Contracts.Module.Registered;

interface

uses
{PROJECT}
  cbsCServer.Module.BaseModule,
{SPRING}
  Spring.Collections;

type
  IcbsModuleRegistered = interface(IUnknown)
    ['{45813152-838E-4E5C-943F-22DC39CE0489}']
    function ToArray: TArray<TdamBaseClass>;
    procedure Add(const AModuleClass: TdamBaseClass);
  end;

  IModuleClassList = IList<TdamBaseClass>;

  function CreateModuleClassList: IModuleClassList;

implementation

function CreateModuleClassList: IModuleClassList;
begin
  Result := TCollections.CreateList<TdamBaseClass>;
end;

end.
