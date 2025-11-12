unit cbs.UserAuthenticationForm;

interface

uses
{PROJECT}
  cbsCliSrv.UserAuthenticationForm,
{IDE}
  uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Imaging.pngimage, uniImage, uniSpeedButton,
  uniButton, uniBitBtn, uniEdit, uniDBEdit, uniGUIClasses, uniMultiItem, uniComboBox, uniDBComboBox, uniDBLookupComboBox, uniLabel, uniPanel, Vcl.Controls, Vcl.Forms;

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
