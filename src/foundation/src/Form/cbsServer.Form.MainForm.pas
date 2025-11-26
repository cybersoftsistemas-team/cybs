unit cbsServer.Form.MainForm;

interface

uses
{PROJECT}
  cbsServer.Form.BaseForm,
{IDE}
  System.Classes, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TfrmMain = class(TfrmBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmMain: TfrmMain;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIVars,
{PROJECT}
  cbsServer.Module.MainModule;

function frmMain: TfrmMain;
begin
  Result := TfrmMain(damMain.GetFormInstance(TfrmMain));
end;

initialization
begin
  RegisterAppFormClass(TfrmMain);
end;

end.
