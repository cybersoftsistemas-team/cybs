unit cbsUAuth.ui.Forms.LoginForm;

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
    procedure AfterConnect;
    procedure BeforeConnect;
    procedure HideMsg;
    procedure OnConnect;
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
  cbsMain.ui.Data.Modules.MainModule,
  cbsSystem.Contracts.Module.Main,
  cbsSystem.Support.Form,
  cbsSystem.Support.RunTime,
  cbsSystem.Support.ServerModule,
  cbsUAuth.ui.Forms.CustomerRegistrationForm,
  cbsUAuth.ui.Data.Modules.LoginModule,
  cbsUAuth.ui.Forms.LoginDomainsForm,
  cbsUAuth.ui.Forms.OptionsForm;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(damMain.GetFormInstance(TfrmLogin));
end;

{ TfrmLogin }

procedure TfrmLogin.actConnectExecute(Sender: TObject);
begin
  try
    BeforeConnect;
    OnConnect;
    AfterConnect;
  except
    on E: Exception do
    begin
      ShowMsg(E.Message);
    end;
  end;
end;

procedure TfrmLogin.actDomainsExecute(Sender: TObject);
begin
  frmLoginDomains.ShowModal(
    procedure(Sender: TComponent; Result: Integer)
    begin
      if Result = mrOk then
      begin
        damLogin.SetDomain(
         frmLoginDomains.DomainId
        ,frmLoginDomains.DomainName);
      end;
      UpdateUi;
    end);
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

procedure TfrmLogin.AfterConnect;
begin
  ModalResult := mrOK;
end;

procedure TfrmLogin.BeforeConnect;
begin
  if damLogin.mtbUSEName.AsString.Trim.IsEmpty then
  begin
    edtUserName.SetFocus;
    raise Exception.CreateFmt('Digite um %s para fazer o login.', [edtUserName.FieldLabel.ToLower]);
  end;
  if damLogin.mtbUSEPassword.AsString.Trim.IsEmpty then
  begin
    edtPassword.SetFocus;
    raise Exception.CreateFmt('Digite uma %s de usuário para fazer o login.', [edtPassword.FieldLabel.ToLower]);
  end;
  if damLogin.mtbUSEDomainId.AsGuid.IsEmpty then
  begin
    btnDomains.SetFocus;
    raise Exception.CreateFmt('Selecione um %s de acesso para fazer o login.', [edtDomainName.FieldLabel.ToLower]);
  end;
end;

procedure TfrmLogin.HideMsg;
begin
  pnlMsg.Visible := False;
end;

procedure TfrmLogin.OnConnect;
begin
  var LError := '';
  if not damLogin.AuthenticateUser(
    damLogin.mtbUSEName.AsString,
    damLogin.mtbUSEPassword.AsString,
    LError) then
  begin
    raise Exception.Create(LError);
  end;
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
  var LExistsRegisteredCustomer := True; //damLogin.ExistsRegisteredCustomer;
  edtUserName.Enabled := not ServerModule.Database.Id.IsEmpty and LExistsRegisteredCustomer;
  edtPassword.Enabled := edtUserName.Enabled;
  edtDomainName.Enabled := edtUserName.Enabled;
  actDomains.Enabled := edtUserName.Enabled;
  actOptions.Visible := RunTime.IsClientRunningInServer;
  actRegister.Visible := actOptions.Visible and not ServerModule.Database.Id.IsEmpty and not LExistsRegisteredCustomer;
  actConnect.Visible := not actOptions.Visible or ServerModule.Database.Id.IsEmpty or LExistsRegisteredCustomer;
  actConnect.Enabled := edtUserName.Enabled;
  HideMsg;
  if actOptions.Visible and damLogin.mtbCNS.Active and damLogin.mtbCNS.IsEmpty then
  begin
    ShowMsg('Não existe uma configuração de conexão com o banco de dados.');
  end
  else if actOptions.Visible and ServerModule.Database.Id.IsEmpty then
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



