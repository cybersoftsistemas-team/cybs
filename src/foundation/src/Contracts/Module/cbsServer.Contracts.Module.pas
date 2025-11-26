unit cbsServer.Contracts.Module;

interface

type
  IcbsModule = interface(IUnknown)
    ['{2AEF67FF-A8C4-453C-94DF-2DF79274C1B5}']
    function GetHandle: HMODULE;
    property Handle: HMODULE read GetHandle;
  end;

implementation

end.
