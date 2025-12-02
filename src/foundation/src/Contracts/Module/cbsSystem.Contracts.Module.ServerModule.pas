unit cbsSystem.Contracts.Module.ServerModule;

interface

type
  IServerModule = interface(IUnknown)
    ['{6C4443A7-3D84-4983-8E21-D3A9562E265F}']
    function GetSystemFilesFolderPath: string;
    property SystemFilesFolderPath: string read GetSystemFilesFolderPath;
  end;

implementation

end.
