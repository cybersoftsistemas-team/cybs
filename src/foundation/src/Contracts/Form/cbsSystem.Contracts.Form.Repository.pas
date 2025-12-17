unit cbsSystem.Contracts.Form.Repository;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{SPRING}
  Spring.Collections;

type
  IFormTypes = IEnumerable<FormType>;
  FormType = cbsSystem.Form.BaseForm.FormType;

  IFormTypeRepository = interface(IUnknown)
    ['{90C65F66-DB44-4943-AFEF-31121D567CB3}']
    function GetFormTypes: IFormTypes;
    function GetMainFormType: FormType;
    procedure Register(const AFormType: FormType);
    procedure RegisterMain(const AFormType: FormType);
  end;

  IFormTypeList = IList<FormType>;

  function CreateFormTypeList: IFormTypeList;

implementation

function CreateFormTypeList: IFormTypeList;
begin
  Result := TCollections.CreateList<FormType>;
end;

end.
