unit cbsclient.Main;

interface

uses
{IDE}
  uniGUIForm;

type
  TMainForm = class(TUniForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetMainForm: TMainForm;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars,
{PROJECT}
  cbsclient.MainModule;

function GetMainForm: TMainForm;
begin
  Result := TMainForm(GetMainModule.GetFormInstance(TMainForm));
end;

initialization
begin
  RegisterAppFormClass(TMainForm);
end;

end.
