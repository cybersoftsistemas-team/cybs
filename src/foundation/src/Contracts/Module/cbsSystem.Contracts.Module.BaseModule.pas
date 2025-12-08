unit cbsSystem.Contracts.Module.BaseModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.BaseForm,
{SPRING}
  Spring.Collections;

type
  IDataModule = interface(IUnknown)
    ['{5FB69ED0-9115-48F8-86F2-5BE8043E3A5B}']
    procedure AddFormListener(const AForm: IForm);
    procedure RemoveFormListener(const AForm: IForm);
  end;

  IFormListenerList = IList<IForm>;

  function CreateFormListenerList: IList<IForm>;

implementation

function CreateFormListenerList: IList<IForm>;
begin
  Result := TCollections.CreateInterfaceList<IForm>;
end;

end.
