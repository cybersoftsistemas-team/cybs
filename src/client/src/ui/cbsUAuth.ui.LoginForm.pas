unit cbsUAuth.ui.LoginForm;

interface

uses
{IDE}
  uniGUITypes, uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Imaging.pngimage,
  uniImage, uniSpeedButton, uniButton, uniBitBtn, uniGUIClasses, uniEdit, uniDBEdit, uniLabel, uniPanel, Vcl.Controls, Vcl.Forms, uniTimer;

type
  TfrmLogin = class(TUniLoginForm)
    aclMain: TUniActionList;
    actConnect: TAction;
    actDomains: TAction;
    actOptions: TAction;
    actRegister: TAction;
    btnConnect: TUniBitBtn;
    btnDomains: TUniSpeedButton;
    btnOptions: TUniBitBtn;
    btnRegister: TUniBitBtn;
    edtDomainName: TUniDBEdit;
    edtPassword: TUniDBEdit;
    edtUserName: TUniDBEdit;
    ilaMain: TUniImageListAdapter;
    imgBckFooter: TUniImage;
    labFooterSubTitle: TUniLabel;
    labFooterTitle: TUniLabel;
    labSubTitle01: TUniLabel;
    labSubTitle02: TUniLabel;
    labTitle01: TUniLabel;
    labTitle02: TUniLabel;
    nilstMain: TUniNativeImageList;
    pnlAuthenticate: TUniPanel;
    pnlBody: TUniSimplePanel;
    pnlButtons: TUniContainerPanel;
    pnlFooter: TUniSimplePanel;
    pnlHeader: TUniSimplePanel;
    pnlMsg: TUniSimplePanel;
    labMsg: TUniLabel;
    imgMsg: TUniImage;
    procedure actConnectExecute(Sender: TObject);
    procedure actDomainsExecute(Sender: TObject);
    procedure actOptionsExecute(Sender: TObject);
    procedure actRegisterExecute(Sender: TObject);
    procedure UniLoginFormActivate(Sender: TObject);
    procedure UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UniLoginFormCreate(Sender: TObject);
  private
    procedure ShowMsg(const ACaption: string);
    procedure UpdateUi;
  end;

  function frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMain.data.module.MainModule,
  cbsSystem.Contracts.Module.Main,
  cbsSystem.Support.Form,
  cbsSystem.Support.RunTime,
  cbsSystem.Support.ServerModule,
  cbsUAuth.data.module.LoginModule,
  cbsUAuth.ui.CustomerRegistrationForm,
  cbsUAuth.ui.DomainsForm,
  cbsUAuth.ui.OptionsForm;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(damMain.GetFormInstance(TfrmLogin));
end;

{ TfrmLogin }

procedure TfrmLogin.actConnectExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmLogin.actDomainsExecute(Sender: TObject);
begin
  frmDomains.ShowModal;
end;

procedure TfrmLogin.actOptionsExecute(Sender: TObject);
begin
  frmOptions.ShowModal(
    procedure(Sender: TComponent; Result: Integer)
    begin
      UpdateUi;
    end);
end;

procedure TfrmLogin.actRegisterExecute(Sender: TObject);
begin
  frmCustomerRegistration.ShowModal(
    procedure(Sender: TComponent; Result: Integer)
    begin
      UpdateUi;
    end);
end;

procedure TfrmLogin.ShowMsg(const ACaption: string);
begin
  labMsg.Caption := ACaption;
  pnlMsg.Visible := True;
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
    (UniApplication.UniMainModule as IMainModule).IsElectron := SameText(Params.Values['value'], 'true');
  end
  else if EventName = 'LoadClientData' then
  begin
    damLogin.LoadData(Params.Values['file'], Params.Values['value']);
  end;
end;

procedure TfrmLogin.UniLoginFormCreate(Sender: TObject);
begin
  UpdateUi;
end;

procedure TfrmLogin.UpdateUi;
begin
  var LExistsRegisteredCustomer := damLogin.ExistsRegisteredCustomer;
  edtUserName.Enabled := not ServerModule.Database.Id.IsEmpty and LExistsRegisteredCustomer;
  edtPassword.Enabled := edtUserName.Enabled;
  edtDomainName.Enabled := edtUserName.Enabled;
  actDomains.Enabled := edtUserName.Enabled;
  actOptions.Visible := RunTime.IsClientRunningInServer;
  actRegister.Visible := actOptions.Visible and not ServerModule.Database.Id.IsEmpty and not LExistsRegisteredCustomer;
  actConnect.Visible := not actOptions.Visible or ServerModule.Database.Id.IsEmpty or LExistsRegisteredCustomer;
  actConnect.Enabled := edtUserName.Enabled;
  pnlMsg.Visible := False;
  if damLogin.mtbCNS.Active and damLogin.mtbCNS.IsEmpty then
  begin
    ShowMsg('Não existe uma configuração de conexão com o banco de dados.');
  end
  else if ServerModule.Database.Id.IsEmpty then
  begin
    ShowMsg('É necessário selecionar uma conexão com o banco de dados.');
  end
  else if actRegister.Visible then
  begin
    ShowMsg('Registre um cliente para ter acesso ao sistema.');
  end
  else if actConnect.Visible and not actConnect.Enabled then
  begin
    ShowMsg('O acesso ao sistema está temporariamente indisponível.');
  end;
end;

initialization
begin
  RegisterFormType(TfrmLogin);
end;

end.
