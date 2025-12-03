unit cbsServer.Module.ServerModule;

interface

uses
{IDE}
  uniGUIServer,
{PROJECT}
  cbsSystem.Contracts.DataStorage,
  cbsSystem.Contracts.Module.ServerModule;

type
  TcbsServerModule = class(TUniGUIServerModule, IServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
  private
    FDataStorage: IcbsDataStorage;
    function GetDataStorage: IcbsDataStorage;
    function GetProgramDataPath: string;
    function GetSystemFilesFolderPath: string;
    procedure HideTrayIconSystem;
  protected
    procedure FirstInit; override;
  public
    property DataStorage: IcbsDataStorage read GetDataStorage;
    property ProgramDataPath: string read GetProgramDataPath;
    property SystemFilesFolderPath: string read GetSystemFilesFolderPath;
  end;

  function cbsServerModule: TcbsServerModule;

implementation

{$R *.dfm}

uses
{IDE}
  FireDAC.Comp.Client,
  Forms,
  System.IOUtils,
  System.SysUtils,
  uniGUIVars,
{$IFDEF MSWINDOWS}
  Winapi.ShellAPI,
{$ENDIF}
{PROJECT}
  cbsSystem.DataStorage,
  cbsSystem.Support.ModuleManager,
  cbsSystem.Support.ServerModule;

function cbsServerModule: TcbsServerModule;
begin
  Result := TcbsServerModule(UniGUIServerInstance);
end;

procedure RegisterAppFormAndModuleClass;
begin
  ModuleManager.LoadFromFolder(TPath.Combine(ExtractFilePath(ParamStr(0))) + 'modules');
  for var LModule in ModuleManager do
  begin
    for var LFormClass in LModule.FormTypes do
    begin
      RegisterAppFormClass(LFormClass);
    end;
    for var LModuleClass in LModule.DataModuleTypes do
    begin
      RegisterModuleClass(LModuleClass);
    end;
  end;
end;

{ TcbsServerModule }

function TcbsServerModule.GetDataStorage: IcbsDataStorage;
begin
  Result := FDataStorage;
end;

function TcbsServerModule.GetProgramDataPath: string;
begin
  Result := TPath.Combine(TPath.GetPublicPath, '.cybersoft', 'config');
  if not DirectoryExists(Result) then
  begin
    ForceDirectories(Result);
  end;
end;

function TcbsServerModule.GetSystemFilesFolderPath: string;
begin
  Result := FilesFolderPath;
end;

procedure TcbsServerModule.FirstInit;
begin
  inherited;
  FDataStorage := TcbsDataStorage.Create(Self);
  InitServerModule(Self);
  RegisterSystemServerModule(Self);
end;

procedure TcbsServerModule.HideTrayIconSystem;
{$IFDEF MSWINDOWS}
var
  LNotifyIconData: TNotifyIconData;
begin
  FillChar(LNotifyIconData, System.SizeOf(TNotifyIconData), 0);
  LNotifyIconData.cbSize := SizeOf(TNotifyIconData);
  LNotifyIconData.Wnd := Application.MainForm.Handle;
  LNotifyIconData.uID := 1002;
  Shell_NotifyIcon(NIM_DELETE, @LNotifyIconData);
end;
{$ELSE}
begin
  // Linux / macOS ? NOP (não existe tray icon)
end;
{$ENDIF}

procedure TcbsServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  HideTrayIconSystem;
end;

procedure TcbsServerModule.UniGUIServerModuleDestroy(Sender: TObject);
begin
  FDataStorage := nil;
end;


initialization
begin
  RegisterServerModuleClass(TcbsServerModule);
  RegisterAppFormAndModuleClass;
  FDManager.Active := True;
end;

finalization
begin
  FDManager.Close;
end;

end.
