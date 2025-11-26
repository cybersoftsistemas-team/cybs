unit cbsCServer.Contracts.Form.Registered;

interface

uses
{PROJECT}
  cbsCServer.Form.BaseForm,
{SPRING}
  Spring.Collections;

type
  IcbsFormRegistered = interface(IUnknown)
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
