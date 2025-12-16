unit cbsMain.data.module.MainModule;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module.Main,
{IDE}
  uniGUIMainModule;

type
  TdamMain = class(TUniGUIMainModule, IMainModule)
  private
    FIsElectron: Boolean;
    function GetIsElectron: Boolean;
    procedure SetIsElectron(const AValue: Boolean);
  public
    property IsElectron: Boolean read GetIsElectron write SetIsElectron;
  end;

  function damMain: TdamMain;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
{PROJECT}
  cbsSystem.Support.Module;

function damMain: TdamMain;
begin
  Result := TdamMain(UniApplication.UniMainModule)
end;

{ TdamMain }

function TdamMain.GetIsElectron: Boolean;
begin
  Result := FIsElectron;
end;

procedure TdamMain.SetIsElectron(const AValue: Boolean);
begin
  FIsElectron := AValue;
end;

initialization
begin
  RegisterMainModuleType(TdamMain);
end;

end.
