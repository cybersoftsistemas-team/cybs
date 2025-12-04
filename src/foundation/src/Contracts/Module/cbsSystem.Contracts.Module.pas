unit cbsSystem.Contracts.Module;

interface

uses
{IDE}
  cbsSystem.Form.BaseForm,
  cbsSystem.Module.BaseModule,
{SPRING}
  Spring.Collections;

type
  IDataModuleTypes = IEnumerable<TdamBaseClass>;
  IFormTypes = IEnumerable<TcbsFormClass>;
  IRequires = IEnumerable<string>;

  IcbsModule = interface(IUnknown)
    ['{2AEF67FF-A8C4-453C-94DF-2DF79274C1B5}']
    function GetDataModuleTypes: IDataModuleTypes;
    function GetFormTypes: IFormTypes;
    function GetHandle: HMODULE;
    function GetName: string;
    function GetRequires: IRequires;
    property DataModuleTypes: IDataModuleTypes read GetDataModuleTypes;
    property FormTypes: IFormTypes read GetFormTypes;
    property Handle: HMODULE read GetHandle;
    property Name: string read GetName;
    property Requires: IRequires read GetRequires;
  end;

  IDataModuleList = IList<TdamBaseClass>;
  IFormTypeList = IList<TcbsFormClass>;
  IRequiredList = IList<string>;

  function CreateDataModuleList: IDataModuleList;
  function CreateFormTypeList: IFormTypeList;
  function CreateRequiredList: IRequiredList;

implementation

function CreateDataModuleList: IDataModuleList;
begin
  Result := TCollections.CreateList<TdamBaseClass>;
end;

function CreateFormTypeList: IFormTypeList;
begin
  Result := TCollections.CreateList<TcbsFormClass>;
end;

function CreateRequiredList: IRequiredList;
begin
  Result := TCollections.CreateList<string>;
end;

end.
