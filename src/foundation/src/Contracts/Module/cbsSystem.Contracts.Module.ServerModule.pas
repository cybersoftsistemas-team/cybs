unit cbsSystem.Contracts.Module.ServerModule;

interface

uses
{PROJECT}
  cbsSystem.Support.Types;

type
  IServerModule = interface(IUnknown)
    ['{6C4443A7-3D84-4983-8E21-D3A9562E265F}']
    function Trans(const APath: string; const ADefaultValue: string = ''): string; overload;
    function Trans(const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string = ''): string; overload;
  end;

implementation

end.
