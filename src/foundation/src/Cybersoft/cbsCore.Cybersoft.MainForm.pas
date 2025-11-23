unit cbsCore.Cybersoft.MainForm;

interface

uses
{PROJECT}
  cbsCore.Cybersoft.BaseForm,
{IDE}
  System.Classes, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TcbsMainForm = class(TcbsBaseForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function cbsMainForm: TcbsMainForm;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIVars,
{PROJECT}
  cbsCore.Cybersoft.MainModule;

function cbsMainForm: TcbsMainForm;
begin
  Result := TcbsMainForm(cbsMainModule.GetFormInstance(TcbsMainForm));
end;

initialization
begin
  RegisterAppFormClass(TcbsMainForm);
end;

end.
