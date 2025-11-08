unit cbsclient.MainModule;

interface

uses
{IDE}
  uniGUIMainModule;

type
  TUniMainModule = class(TUniGUIMainModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars,
{PROJECT}
  cbsclient.ServerModule;

function GetMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

initialization
begin
  RegisterMainModuleClass(TUniMainModule);
end;

end.
