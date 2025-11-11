unit cbs.MainForm;

interface

uses
{PROJECT}
  cbsCliSrv.MainBaseForm,
{IDE}
  uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TcbsMainForm = class(TcbsCliSrvMainBaseForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetMainForm: TcbsMainForm;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars,
{PROJECT}
  cbs.MainModule;

function GetMainForm: TcbsMainForm;
begin
  Result := TcbsMainForm(GetMainModule.GetFormInstance(TcbsMainForm));
end;

initialization
begin
  RegisterAppFormClass(TcbsMainForm);
end;

end.
