unit cbs.UserAuthenticationForm;

interface

uses
{PROJECT}
  cbsCliSrv.UserAuthenticationForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu;

type
  TcbsUserAuthenticationForm = class(TcbsCliSrvUserAuthenticationForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetUserAuthenticationForm: TcbsUserAuthenticationForm;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIApplication,
  uniGUIVars,
{PROJECT}
  cbs.UserAuthenticationModule;

function GetUserAuthenticationForm: TcbsUserAuthenticationForm;
begin
  Result := TcbsUserAuthenticationForm(GetcbsUserAuthenticationModule.GetFormInstance(TcbsUserAuthenticationForm));
end;

initialization
begin
  RegisterAppFormClass(TcbsUserAuthenticationForm);
end;

end.
