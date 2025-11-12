unit cbs.ServerModule;

interface

uses
{PROJECT}
  cbsCliSrv.ServerBaseModule,
{IDE}
  System.SysUtils;

type
  TcbsServerModule = class(TcbsCliSrvBaseModule)
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
  uniGUIVars,
  VCL.Forms,
  Winapi.ShellAPI;

function cbsServerModule: TcbsServerModule;
begin
  Result := TcbsServerModule(UniGUIServerInstance);
end;

{ TcbsServerModule }

procedure TcbsServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

procedure TcbsServerModule.HideTrayIconSystem;
var
  LNotifyIconData: TNotifyIconData;
begin
  FillChar(LNotifyIconData, System.SizeOf(TNotifyIconData), 0);
  LNotifyIconData.cbSize := SizeOf(TNotifyIconData);
  LNotifyIconData.Wnd := Application.MainForm.Handle;
  LNotifyIconData.uID := 1002;
  Shell_NotifyIcon(NIM_DELETE, @LNotifyIconData);
end;

procedure TcbsServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  inherited;
  HideTrayIconSystem;
end;

initialization
begin
  RegisterServerModuleClass(TcbsServerModule);
end;

end.
