unit cbsServer.Module.ServerModule;

interface

uses
{IDE}
  uniGUIServer,
{PROJECT}
  cbsSystem.Contracts.Database,
  cbsSystem.Contracts.DataStorage,
  cbsSystem.Contracts.Module.ServerModule,
  cbsSystem.Contracts.Translation.Translator,
  cbsSystem.Support.Types;

type
  TcbsServerModule = class(TUniGUIServerModule, IServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
  private
    FDatabase: IcbsDatabase;
    FDataStorage: IcbsDataStorage;
    FTranslator: ITranslator;
    function GetDatabase: IcbsDatabase;
    function GetDataStorage: IcbsDataStorage;
    function GetProgramDataConfigPath: string;
    function GetSystemFilesFolderPath: string;
    procedure HideTrayIconSystem;
  protected
    procedure FirstInit; override;
  public
    function Trans(const APath: string; const ADefaultValue: string = ''): string; overload;
    function Trans(const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string = ''): string; overload;
    property Database: IcbsDatabase read GetDatabase;
    property DataStorage: IcbsDataStorage read GetDataStorage;
    property ProgramDataConfigPath: string read GetProgramDataConfigPath;
    property SystemFilesFolderPath: string read GetSystemFilesFolderPath;
  end;

  function cbsServerModule: TcbsServerModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

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
  cbsServer.Database,
  cbsSystem.Contracts.Database.Seeders.DatabaseSeeder,
  cbsSystem.Contracts.MessageBag,
  cbsSystem.Contracts.Validation.Rules.PasswordPolicy,
  cbsSystem.DataStorage,
  cbsSystem.Locales.Locale,
  cbsSystem.MessageBag,
  cbsSystem.Support.DatabaseSeederTypeRepository,
  cbsSystem.Support.RegisterContainer,
  cbsSystem.Support.FormTypeRepository,
  cbsSystem.Support.ModuleManager,
  cbsSystem.Support.ModuleTypeRepository,
  cbsSystem.Support.Translations,
  cbsSystem.Support.ServerModule,
  cbsSystem.Translation.Translator,
  cbsSystem.Validation.Rules.PasswordPolicy,
  Shared.Inf.Database.Connection,
  Shared.UI.Data.Modules.MainModule,
  Shared.UI.Forms.MainForm,
{SPRING}
  Spring.Container;

function cbsServerModule: TcbsServerModule;
begin
  Result := TcbsServerModule(UniGUIServerInstance);
end;

procedure LoadSystemModules;
begin
  ModuleManager.LoadFromFolder(ExtractFilePath(ParamStr(0)));
end;

procedure RegisterAppFormsAndDataModules;
begin
  for var LModuleType in ModuleTypeRepository.GetModuleTypes do
  begin
    RegisterModuleClass(LModuleType);
  end;
  for var LFormType in FormTypeRepository.GetFormTypes do
  begin
    RegisterAppFormClass(LFormType);
  end;
end;

procedure RegisterContainerTypes;
begin
  for var LItem in Container do
  begin
    var LShared := LItem.Value.Value;
    var LRegisterType := if Assigned(LItem.Value.Key) then
      GlobalContainer.RegisterType(LItem.Key, LItem.Value.Key)
    else
      GlobalContainer.RegisterType(LItem.Key, LItem.Key);
    if Assigned(LRegisterType) and LShared then
    begin
      LRegisterType.AsSingleton;
    end;
  end;
  for var LDbSeederType in DatabaseSeederTypeRepository do
  begin
    GlobalContainer.RegisterType(LDbSeederType.ClassInfo).Implements<IDatabaseSeeder>(LDbSeederType.QualifiedClassName);
  end;
  GlobalContainer.RegisterType<PasswordPolicy>.Implements<IPasswordPolicy>;
  GlobalContainer.RegisterType<TMessageBag>.Implements<IMessageBag>;
  GlobalContainer.RegisterType<TTranslator>.Implements<ITranslator>.AsSingleton;
  GlobalContainer.Build;
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

function TcbsServerModule.Trans(const APath, ADefaultValue: string): string;
begin
  Result := FTranslator.Translation(APath, ADefaultValue);
end;

function TcbsServerModule.Trans(const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string): string;
begin
  Result := FTranslator.Translation(APath, AReplacements, ADefaultValue);
end;

procedure TcbsServerModule.FirstInit;
begin
  inherited;
  InitServerModule(Self);
  RegisterInternalSystemServerModule(Self);
  FDataStorage := TcbsDataStorage.Create(Self);
  FDatabase := TDatabase.Create(Self, TdamDb);
  FDatabase.ExecuteMigrations;
  FTranslator := GlobalContainer.Resolve<ITranslator>;
  FTranslator.Locale := TLocale.pt_br;
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
  FTranslator := nil;
end;

initialization
begin
  RegisterServerModuleClass(TcbsServerModule);
  RegisterMainModuleClass(TdamMain);
  RegisterMainFormClass(TfrmMain);
  RegisterModuleClass(TdamDb);
  LoadSystemModules;
  RegisterContainerTypes;
  RegisterAppFormsAndDataModules;
  FDManager.Open;
  CreateTranslations;
end;

finalization
begin
  FDManager.Close;
  CleanupGlobalContainer;
  DestroyTranslations;
end;

end.
