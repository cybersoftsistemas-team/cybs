unit cbsServer.Module.ServerModule;

interface

uses
{IDE}
  uniGUIServer;

type
  TcbsServerModule = class(TUniGUIServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
  private
    procedure HideTrayIconSystem;
  protected
    procedure FirstInit; override;
  end;

  function cbsServerModule: TcbsServerModule;

implementation

{$R *.dfm}

uses
{IDE}
  Forms,
  System.SysUtils,
  uniGUIVars,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
  Winapi.ShellAPI,
{$ENDIF}
{PROJECT}
  cbsServer.Support.ModuleManager;

function cbsServerModule: TcbsServerModule;
begin
  Result := TcbsServerModule(UniGUIServerInstance);
end;

{ TcbsServerModule }

procedure TcbsServerModule.FirstInit;
begin
  inherited;
  InitServerModule(Self);
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
  // Linux / macOS → NOP (não existe tray icon)
end;
{$ENDIF}

procedure TcbsServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  HideTrayIconSystem;
  ModuleManager.LoadFromFolder(StartPath + 'modules');
end;

initialization
begin
  RegisterServerModuleClass(TcbsServerModule);
end;

end.
