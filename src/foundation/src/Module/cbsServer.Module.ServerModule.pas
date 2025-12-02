unit cbsServer.Module.ServerModule;

interface

uses
{IDE}
  uniGUIServer,
{PROJECT}
  cbsSystem.Contracts.Module.ServerModule;

type
  TcbsServerModule = class(TUniGUIServerModule, IServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
  private
    procedure HideTrayIconSystem;
    function GetSystemFilesFolderPath: string;
  protected
    procedure FirstInit; override;
  public
    property SystemFilesFolderPath: string read GetSystemFilesFolderPath;
  end;

  function cbsServerModule: TcbsServerModule;

implementation

{$R *.dfm}

uses
{IDE}
  FireDAC.Comp.Client,
  Forms,
  System.SysUtils,
  uniGUIVars,
{$IFDEF MSWINDOWS}
  Winapi.ShellAPI,
{$ENDIF}
{PROJECT}
  cbsSystem.Support.ModuleManager,
  cbsSystem.Support.ServerModule;

function cbsServerModule: TcbsServerModule;
begin
  Result := TcbsServerModule(UniGUIServerInstance);
end;

procedure RegisterAppFormAndModuleClass;
begin
  ModuleManager.LoadFromFolder(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'modules');
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

procedure TcbsServerModule.FirstInit;
begin
  inherited;
  InitServerModule(Self);
  RegisterSystemServerModule(Self);
end;

function TcbsServerModule.GetSystemFilesFolderPath: string;
begin
  Result := FilesFolderPath;
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
  RegisterServerModuleClass(TcbsServerModule);
  RegisterAppFormAndModuleClass;
  FDManager.Active := True;
end;

finalization
begin
  FDManager.Close;
end;

end.
