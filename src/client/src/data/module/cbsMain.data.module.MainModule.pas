unit cbsMain.data.module.MainModule;

interface

uses
{PROJECT}
  cbsMain.inf.DbModule,
  cbsSystem.Contracts.Module.Main,
{IDE}
  uniGUIMainModule;

type
  TdamMain = class(TUniGUIMainModule, IMainModule)
    procedure UniGUIMainModuleCreate(Sender: TObject);
  private
    FdamDb: TdamDb;
    FIsElectron: Boolean;
    function GetIsElectron: Boolean;
    procedure SetIsElectron(const AValue: Boolean);
  public
    property damDb: TdamDb read FdamDb;
    property IsElectron: Boolean read GetIsElectron write SetIsElectron;
  end;

  function damMain: TdamMain;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication;

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

procedure TdamMain.UniGUIMainModuleCreate(Sender: TObject);
begin
  FdamDb := TdamDb.Create(Self);
end;

end.
