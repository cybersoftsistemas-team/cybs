unit cbsServer.Contracts.Module;

interface

uses
{IDE}
  cbsServer.Module.Api;

type
  IcbsModule = interface(IUnknown)
    ['{2AEF67FF-A8C4-453C-94DF-2DF79274C1B5}']
    function GetHandle: HMODULE;
    function GetInfo: TcbsModuleInfo;
    property Handle: HMODULE read GetHandle;
    property Info: TcbsModuleInfo read GetInfo;
  end;

implementation

end.
