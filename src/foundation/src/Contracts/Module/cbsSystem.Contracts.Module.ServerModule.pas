unit cbsSystem.Contracts.Module.ServerModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Database,
  cbsSystem.Contracts.DataStorage;

type
  IServerModule = interface(IUnknown)
    ['{6C4443A7-3D84-4983-8E21-D3A9562E265F}']
    function GetDatabase: IcbsDatabase;
    function GetDataStorage: IcbsDataStorage;
    function GetProgramDataConfigPath: string;
    function GetSystemFilesFolderPath: string;
    property Database: IcbsDatabase read GetDatabase;
    property DataStorage: IcbsDataStorage read GetDataStorage;
    property ProgramDataConfigPath: string read GetProgramDataConfigPath;
    property SystemFilesFolderPath: string read GetSystemFilesFolderPath;
  end;

implementation

end.
