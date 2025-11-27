unit cbsUAuth.ui.LoginForm;

interface

uses
{IDE}
  uniGUITypes, uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Imaging.pngimage,
  uniImage, uniSpeedButton, uniButton, uniBitBtn, uniGUIClasses, uniEdit, uniDBEdit, uniLabel, uniPanel, Vcl.Controls, Vcl.Forms;

type
  TfrmLogin = class(TUniLoginForm)
    aclMain: TUniActionList;
    ilaMain: TUniImageListAdapter;
    actConnect: TAction;
    actOptions: TAction;
    actDomains: TAction;
    pnlAuthenticate: TUniPanel;
    pnlHeader: TUniSimplePanel;
    labSubTitle02: TUniLabel;
    labTitle01: TUniLabel;
    labTitle02: TUniLabel;
    labSubTitle01: TUniLabel;
    pnlBody: TUniSimplePanel;
    edtUserName: TUniDBEdit;
    edtPassword: TUniDBEdit;
    edtDomainName: TUniDBEdit;
    btnConnect: TUniBitBtn;
    btnOptions: TUniBitBtn;
    btnDomains: TUniSpeedButton;
    pnlFooter: TUniSimplePanel;
    labFooterTitle: TUniLabel;
    labFooterSubTitle: TUniLabel;
    nilstMain: TUniNativeImageList;
    UniImage1: TUniImage;
    procedure UniLoginFormCreate(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure UniLoginFormActivate(Sender: TObject);
    procedure UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure actOptionsExecute(Sender: TObject);
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
  System.SysUtils,
  uniGUIApplication,
{PROJECT}
  cbsSystem.Support.Form,
  cbsSystem.Support.RunTime,
  cbsUAuth.data.module.LoginModule,
  cbsUAuth.ui.OptionsForm;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(UniApplication.UniMainModule.GetFormInstance(TfrmLogin));
end;

{ TfrmLogin }

procedure TfrmLogin.UniLoginFormCreate(Sender: TObject);
begin
  actOptions.Visible := RunTime.IsClientRunningInServer;
  if not actOptions.Visible then
  begin
    btnConnect.Left := btnDomains.Left - btnConnect.Width + btnDomains.Width;
  end;
end;

procedure TfrmLogin.actConnectExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmLogin.actOptionsExecute(Sender: TObject);
begin
  frmOptions.ShowModal;
end;

procedure TfrmLogin.UniLoginFormActivate(Sender: TObject);
begin
  if not SameText(string(edtUserName.Text).Trim, '') then
  begin
    edtPassword.SetFocus;
  end;
end;

procedure TfrmLogin.UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
begin
  if EventName = 'IsElectron' then
  begin
    RunTime.IsElectron := SameText(Params.Values['value'], 'true');
  end
  else if EventName = 'LoadClientData' then
  begin
    damLogin.LoadData(Params.Values['file'], Params.Values['value']);
  end;
end;

initialization
begin
  RegisterFormClass(TfrmLogin);
end;

end.
