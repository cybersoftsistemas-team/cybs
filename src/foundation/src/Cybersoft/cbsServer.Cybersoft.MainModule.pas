unit cbsServer.Cybersoft.MainModule;

interface

uses
{IDE}
  uniGUIMainModule;

type
  TcbsMainModule = class(TUniGUIMainModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function cbsMainModule: TcbsMainModule;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars;

function cbsMainModule: TcbsMainModule;
begin
  Result := TcbsMainModule(UniApplication.UniMainModule)
end;

initialization
begin
  RegisterMainModuleClass(TcbsMainModule);
end;

end.
