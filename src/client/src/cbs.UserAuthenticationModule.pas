unit cbs.UserAuthenticationModule;

interface

uses
{PROJECT}
  cbsCliSrv.UserAuthenticationModule, cbsCliSrv.MainBaseModule;

type
  TcbsUserAuthenticationModule = class(TcbsCliSrvUserAuthenticationModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetcbsUserAuthenticationModule: TcbsUserAuthenticationModule;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars,
{PROJECT}
  cbs.MainModule;

function GetcbsUserAuthenticationModule: TcbsUserAuthenticationModule;
begin
  Result := TcbsUserAuthenticationModule(GetMainModule.GetModuleInstance(TcbsUserAuthenticationModule));
end;

initialization
begin
  RegisterModuleClass(TcbsUserAuthenticationModule);
end;

end.
