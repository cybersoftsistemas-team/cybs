unit cbsServer.Contracts.Registered.Forms;

interface

uses
{PROJECT}
  cbsServer.Cybersoft.BaseForm,
{SPRING}
  Spring.Collections;

type
  IcbsRegisteredForms = interface(IUnknown)
    ['{90C65F66-DB44-4943-AFEF-31121D567CB3}']
    function ToArray: TArray<TcbsFormClass>;
    procedure Add(const AFormClass: TcbsFormClass);
  end;

  IFormClassList = IList<TcbsFormClass>;

  function CreateFormClassList: IFormClassList;

implementation

function CreateFormClassList: IFormClassList;
begin
  Result := TCollections.CreateList<TcbsFormClass>;
end;

end.
