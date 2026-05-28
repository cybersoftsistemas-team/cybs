unit cbsServer.Module.ServerModule;

interface

uses
{IDE}
  uniGUIServer,
{PROJECT}
  cbsSystem.Contracts.Module.ServerModule,
  cbsSystem.Contracts.Translation.Translator,
  cbsSystem.Support.Types;

type
  TcbsServerModule = class(TUniGUIServerModule, IServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
  private
    FTranslator: ITranslator;
    procedure HideTrayIconSystem;
  protected
    procedure FirstInit; override;
  public
    function Trans(const APath: string; const ADefaultValue: string = ''): string; overload;
    function Trans(const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string = ''): string; overload;
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
  cbsSystem.Locales.Locale,
  cbsSystem.Support.Bootstrap,
  cbsSystem.Support.Container,
  cbsSystem.Support.DatabaseSeederTypeRepository,
  cbsSystem.Support.RegisterContainer,
  cbsSystem.Support.FormTypeRepository,
  cbsSystem.Support.ModuleTypeRepository,
  cbsSystem.Support.Translations,
  cbsSystem.Support.ServerModule,
  cbsSystem.Translation.Translator,
  Shared.Inf.Contracts.Services.DatabaseUpdaterService,
  Shared.Inf.Database.Connection,
  Shared.Inf.Database.Context,
  Shared.Inf.Services.DatabaseUpdaterService,
  Shared.UI.Data.Modules.MainModule,
  Shared.UI.Forms.MainForm;

type
  TBootstrap = cbsSystem.Support.Bootstrap.Bootstrap;

function cbsServerModule: TcbsServerModule;
begin
  Result := TcbsServerModule(UniGUIServerInstance);
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

{ TcbsServerModule }

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
  FTranslator := cbsSystem.Support.Container.App.Make<ITranslator>;
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

initialization
begin
  TBootstrap.ImplementSingleton<TdamDb>;
  TBootstrap.ImplementSingleton<TDbContext>;
  TBootstrap.ImplementSingleton<IDatabaseUpdaterService, TDatabaseUpdaterService>;
  TBootstrap.Initialize;
  RegisterServerModuleClass(TcbsServerModule);
  RegisterMainModuleClass(TdamMain);
  RegisterMainFormClass(TfrmMain);
  RegisterModuleClass(TdamDb);
  RegisterAppFormsAndDataModules;
  FDManager.Open;
end;

finalization
begin
  FDManager.Close;
  TBootstrap.Finalize;
end;

end.
