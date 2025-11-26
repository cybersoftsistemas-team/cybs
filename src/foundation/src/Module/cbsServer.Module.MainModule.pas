unit cbsServer.Module.MainModule;

interface

uses
{IDE}
  uniGUIMainModule;

type
  TdamMain = class(TUniGUIMainModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function damMain: TdamMain;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars;

function damMain: TdamMain;
begin
  Result := TdamMain(UniApplication.UniMainModule)
end;

initialization
begin
  RegisterMainModuleClass(TdamMain);
end;

end.
