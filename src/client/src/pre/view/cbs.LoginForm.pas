unit cbs.LoginForm;

interface

uses
{PROJECT}
  cbsCliSrv.UserAuthForm,
{IDE}
  uniGUITypes, uniGUIBaseClasses, System.Classes, uniImageList, System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Imaging.pngimage, uniImage,
  uniSpeedButton, uniButton, uniBitBtn, uniGUIClasses, uniEdit, uniDBEdit, uniLabel, uniPanel, Vcl.Controls, Vcl.Forms;

type
  TfrmLogin = class(TcbsCliSrvUserAuthForm)
    procedure actConnectExecute(Sender: TObject);
    procedure UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses
{IDE}
  uniGUIVars,
{PROJECT}
  cbs.LoginModule;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(damLogin.GetFormInstance(TfrmLogin));
end;

procedure TfrmLogin.actConnectExecute(Sender: TObject);
begin
  damLogin.SaveLogonData;
  inherited;
end;

procedure TfrmLogin.UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  inherited;
  if EventName = 'LoadClientData' then
  begin
    damLogin.LoadData(Params.Values['file'], Params.Values['value']);
  end;
end;

initialization
begin
  RegisterAppFormClass(TfrmLogin);
end;

end.
