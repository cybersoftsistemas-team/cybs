unit cbsSystem.Contracts.Module;

interface

uses
{IDE}
  cbsSystem.Form.BaseForm,
  cbsSystem.Module.BaseModule,
{SPRING}
  Spring.Collections;

type
  IcbsModule = interface(IUnknown)
    ['{2AEF67FF-A8C4-453C-94DF-2DF79274C1B5}']
    function DataModuleTypes: TArray<TdamBaseClass>;
    function FormTypes: TArray<TcbsFormClass>;
    function GetHandle: HMODULE;
    property Handle: HMODULE read GetHandle;
  end;

  IDataModuleList = IList<TdamBaseClass>;
  IFormTypeList = IList<TcbsFormClass>;

  function CreateDataModuleList: IDataModuleList;
  function CreateFormTypeList: IFormTypeList;

implementation

function CreateDataModuleList: IDataModuleList;
begin
  Result := TCollections.CreateList<TdamBaseClass>;
end;

function CreateFormTypeList: IFormTypeList;
begin
  Result := TCollections.CreateList<TcbsFormClass>;
end;

end.
