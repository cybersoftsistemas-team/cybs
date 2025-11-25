unit cbsServer.ModuleManager;

interface

uses
{PROJECT}
  cbsServer.Contracts.ModuleManager;

type
  TcbsModuleManager = class(TInterfacedObject, IcbsModuleManager)
  strict private
    LModuleList: IModuleList;
    function GetModuleMask: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure LoadFromFolder(const AFolder: string);
  end;

implementation

uses
{IDE}
  System.IOUtils,
  System.SysUtils,
{PROJECT}
  cbsServer.Module,
  cbsServer.Module.Api;

{ TcbsModuleManager }

constructor TcbsModuleManager.Create;
begin
  inherited Create;
  LModuleList := CreateModuleList;
end;

destructor TcbsModuleManager.Destroy;
begin
  LModuleList.Clear;
  inherited;
end;

function TcbsModuleManager.GetModuleMask: string;
begin
  Result := '*' + string(GetModuleExtension);
end;

procedure TcbsModuleManager.LoadFromFolder(const AFolder: string);
begin
  if not TDirectory.Exists(AFolder) then
  begin
    Exit;
  end;
  var LMask := GetModuleMask;
  var LFiles := TDirectory.GetFiles(
    AFolder,
    LMask,
    TSearchOption.soTopDirectoryOnly
  );
  for var LFile in LFiles do
  begin
    var LModule := TcbsModule.Create(LFile);
    LModuleList.Add(LModule);
  end;
end;

end.
