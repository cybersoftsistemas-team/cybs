unit cbs.MainModule;

interface

uses
{IDE}
  cbsCliSrv.MainBaseModule;

type
  TcbsMainModule = class(TcbsCliSrvMainBaseModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetMainModule: TcbsMainModule;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars;

function GetMainModule: TcbsMainModule;
begin
  Result := TcbsMainModule(UniApplication.UniMainModule)
end;

initialization
begin
  RegisterMainModuleClass(TcbsMainModule);
end;

end.
