unit cbsSystem.Contracts.Validation.Rule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag;

type
  IRule = interface(IUnknown)
    ['{AA00570E-974A-495C-949A-5B1105A0830F}']
    function Messages: IMessageBag;
  end;

implementation

end.
