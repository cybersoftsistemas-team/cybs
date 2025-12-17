unit cbsMain.ui.MainForm;

interface

uses
{PROJECT}
  cbsSystem.Form.BaseForm,
{IDE}
  uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

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
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsSystem.Support.Form;

function frmMain: TfrmMain;
begin
  Result := TfrmMain(damMain.GetFormInstance(TfrmMain));
end;

initialization
begin
  RegisterMainFormType(TfrmMain);
end;

end.
