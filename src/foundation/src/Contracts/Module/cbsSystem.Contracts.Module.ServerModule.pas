unit cbsSystem.Contracts.Module.ServerModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.DataStorage;

type
  IServerModule = interface(IUnknown)
    ['{6C4443A7-3D84-4983-8E21-D3A9562E265F}']
    function GetDataStorage: IcbsDataStorage;
    function GetProgramDataPath: string;
    function GetSystemFilesFolderPath: string;
    procedure ExecuteMigrations;
    property DataStorage: IcbsDataStorage read GetDataStorage;
    property ProgramDataPath: string read GetProgramDataPath;
    property SystemFilesFolderPath: string read GetSystemFilesFolderPath;
  end;

implementation

end.
