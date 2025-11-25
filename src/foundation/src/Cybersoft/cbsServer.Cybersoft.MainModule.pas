unit cbsServer.Cybersoft.MainModule;

interface

uses
{IDE}
  uniGUIMainModule;

type
  TdamMainModule = class(TUniGUIMainModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function damMainModule: TdamMainModule;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars;

function damMainModule: TdamMainModule;
begin
  Result := TdamMainModule(UniApplication.UniMainModule)
end;

initialization
begin
  RegisterMainModuleClass(TdamMainModule);
end;

end.
