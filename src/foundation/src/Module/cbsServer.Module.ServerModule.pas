unit cbsServer.Module.ServerModule;

interface

uses
{IDE}
  uniGUIServer,
{PROJECT}
  cbsSystem.Contracts.Database,
  cbsSystem.Contracts.DataStorage,
  cbsSystem.Contracts.Module.ServerModule;

type
  TcbsServerModule = class(TUniGUIServerModule, IServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
  private
    FDatabase: IcbsDatabase;
    FDataStorage: IcbsDataStorage;
    function GetDatabase: IcbsDatabase;
    function GetDataStorage: IcbsDataStorage;
    function GetProgramDataConfigPath: string;
    function GetSystemFilesFolderPath: string;
    procedure HideTrayIconSystem;
  protected
    procedure FirstInit; override;
  public
    property Database: IcbsDatabase read GetDatabase;
    property DataStorage: IcbsDataStorage read GetDataStorage;
    property ProgramDataConfigPath: string read GetProgramDataConfigPath;
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
  cbsSystem.Database,
  cbsSystem.DataStorage,
  cbsSystem.Support.FormTypeRepository,
  cbsSystem.Support.ModuleManager,
  cbsSystem.Support.ModuleTypeRepository,
  cbsSystem.Support.ServerModule;

function cbsServerModule: TcbsServerModule;
begin
  Result := TcbsServerModule(UniGUIServerInstance);
end;

procedure LoadSystemModules;
begin
  ModuleManager.LoadFromFolder(TPath.Combine(ExtractFilePath(ParamStr(0)), 'modules'));
end;

procedure RegisterAppFormsAndDataModules;
begin
  RegisterMainModuleClass(ModuleTypeRepository.GetMainModule);
  RegisterMainFormClass(FormTypeRepository.GetMainFormType);
  for var LModuleType in ModuleTypeRepository.GetModuleTypes do
  begin
    RegisterModuleClass(LModuleType);
  end;
  for var LFormType in FormTypeRepository.GetFormTypes do
  begin
    RegisterAppFormClass(LFormType);
  end;
end;

{ TcbsServerModule }

function TcbsServerModule.GetDatabase: IcbsDatabase;
begin
  Result := FDatabase;
end;

function TcbsServerModule.GetDataStorage: IcbsDataStorage;
begin
  Result := FDataStorage;
end;

function TcbsServerModule.GetProgramDataConfigPath: string;
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
  InitServerModule(Self);
  FDataStorage := TcbsDataStorage.Create(Self);
  FDatabase := TcbsDatabase.Create(Self);
  RegisterInternalSystemServerModule(Self);
  FDatabase.ExecuteMigrations;
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
  FDatabase := nil;
end;

initialization
begin
  RegisterServerModuleClass(TcbsServerModule);
  LoadSystemModules;
  RegisterAppFormsAndDataModules;
  FDManager.Open;
end;

finalization
begin
  FDManager.Close;
end;

end.
