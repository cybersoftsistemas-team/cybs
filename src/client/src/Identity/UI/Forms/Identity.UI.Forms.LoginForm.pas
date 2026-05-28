unit Identity.UI.Forms.LoginForm;

interface

uses
{PROJECT}
  cbsSystem.Contracts.DatabaseConfig,
{IDE}
  uniGUITypes, uniGUIForm, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, Vcl.Imaging.pngimage,
  uniImage, uniSpeedButton, uniButton, uniBitBtn, uniGUIClasses, uniEdit, uniDBEdit, uniLabel, uniPanel, Vcl.Controls, Vcl.Forms, uniTimer, uniCheckBox, uniDBCheckBox,
  uniScreenMask;

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
    cbxRememberYourLoginCredentials: TUniDBCheckBox;
    usmSelected: TUniScreenMask;
    procedure actConnectExecute(Sender: TObject);
    procedure actDomainsExecute(Sender: TObject);
    procedure actOptionsExecute(Sender: TObject);
    procedure actRegisterExecute(Sender: TObject);
    procedure UniLoginFormActivate(Sender: TObject);
    procedure UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UniLoginFormCreate(Sender: TObject);
  private
    FDatabaseConfig: IDatabaseConfig;
    procedure AfterConnect;
    procedure BeforeConnect;
    procedure HideMsg;
    procedure OnConnect(var AModalResult: Integer);
    procedure ShowMsg(const ACaption: string);
    procedure UpdateUi;
  end;

  function frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  System.UITypes,
{PROJECT}
  cbsSystem.Support.Container,
  cbsSystem.Support.Form,
  Identity.Dom.Common.SystemOptions,
  Identity.Inf.Entities,
  Identity.UI.Data.Modules.LoginDomainsModule,
  Identity.UI.Data.Modules.LoginModule,
  Identity.UI.Forms.LoginChangePassword,
  Identity.UI.Forms.LoginDomainRegistrationForm,
  Identity.UI.Forms.LoginDomainsForm,
  Identity.UI.Forms.LoginOptionsForm,
  Shared.Core.Common.RunTime,
  Shared.UI.Contracts.Data.Modules.MainModule,
  Shared.UI.Data.Modules.MainModule;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(damMain.GetFormInstance(TfrmLogin));
end;

{ TfrmLogin }

procedure TfrmLogin.actConnectExecute(Sender: TObject);
begin
  var LModalResult := mrOk;
  try
    BeforeConnect;
    OnConnect(LModalResult);
    AfterConnect;
    ModalResult := LModalResult;
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
        damLogin.SetDomain(frmLoginDomains.DomainName);
      end;
      UpdateUi;
    end);
end;

procedure TfrmLogin.actOptionsExecute(Sender: TObject);
begin
  frmLoginOptions.ShowModal(
    procedure(Sender: TComponent; Result: Integer)
    begin
      UpdateUi;
    end);
end;

procedure TfrmLogin.actRegisterExecute(Sender: TObject);
begin
  frmDomainRegistration.ShowModal(
    procedure(Sender: TComponent; Result: Integer)
    begin
      UpdateUi;
      if Result = mrOk then
        damLogin.mtbUSEName.FocusControl;
    end);
end;

procedure TfrmLogin.AfterConnect;
begin
  damLogin.SaveLogonData;
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
  if damLogin.mtbUSEDomainName.AsString.Trim.IsEmpty then
  begin
    btnDomains.SetFocus;
    raise Exception.CreateFmt('Selecione um %s de acesso para fazer o login.', [edtDomainName.FieldLabel.ToLower]);
  end;
  if not damLoginDomains.ExistsDomain(damLogin.mtbUSEDomainName.AsString) then
  begin
    damLogin.mtbUSEDomainName.Clear;
    damLogin.mtbUSEDomainName.FocusControl;
    raise Exception.CreateFmt('O domínio de acesso %s não pôde ser encontrado.', [damLogin.mtbUSEDomainName.AsString]);
  end;
  if not damLoginDomains.ExistsAccess(damLogin.mtbUSEDomainName.AsString, damLogin.mtbUSEName.AsString) then
  begin
    MessageDlg(Format('O usuário %s não tem acesso ao domínio %s.',
      [damLogin.mtbUSEName.AsString, damLogin.mtbUSEDomainName.AsString]), TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK]);
  end;
end;

procedure TfrmLogin.HideMsg;
begin
  pnlMsg.Visible := False;
end;

procedure TfrmLogin.OnConnect(var AModalResult: Integer);
begin
  var LResult := damLogin.AuthenticateUser(damLogin.mtbUSEName.AsString, damLogin.mtbUSEPassword.AsString);
  if LResult.IsSuccess then
  begin
    var LUser := LResult.Value;
    try
      if LUser.Settings.First(
        function(const ASetting: TSettingEntity): Boolean
        begin
          Result := IsEqualGUID(
            ASetting.OptionId,
            TSystemOptions.ChangePasswordOnNextLoginId
          );
        end
      ).Checked then
      begin
        AModalResult := mrNone;
        var LUserId := LUser.Id;
        MessageDlg('Você precisa alterar sua senha para continuar.', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK],
          procedure(Sender: TComponent; Result: Integer)
          begin
            damLogin.ClearUserPassword;
            frmLoginChangePassword.UserId := LUserId;
            frmLoginChangePassword.ShowModal(
              procedure(Sender: TComponent; Result: Integer)
              begin
                UpdateUi;
              end);
          end);
      end;
    finally
      LUser.Free;
    end;
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
    damLogin.mtbUSEPassword.FocusControl;
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
  inherited;
  FDatabaseConfig := App.Make<IDatabaseConfig>;
  UpdateUi;
end;

procedure TfrmLogin.UpdateUi;
begin
  var LExistsRegisteredDomain := damLoginDomains.ExistsRegisteredDomain;
  edtUserName.Enabled := FDatabaseConfig.Exists and LExistsRegisteredDomain;
  edtPassword.Enabled := edtUserName.Enabled;
  edtDomainName.Enabled := edtUserName.Enabled;
  actDomains.Enabled := edtUserName.Enabled;
  cbxRememberYourLoginCredentials.Enabled := edtUserName.Enabled;
  actOptions.Visible := RunTime.IsClientRunningInServer;
  actRegister.Visible := actOptions.Visible and FDatabaseConfig.Exists and not LExistsRegisteredDomain;
  actConnect.Visible := not actOptions.Visible or not FDatabaseConfig.Exists or LExistsRegisteredDomain;
  actConnect.Enabled := edtUserName.Enabled;
  HideMsg;
  if actOptions.Visible and damLogin.mtbCNS.Active and damLogin.mtbCNS.IsEmpty then
  begin
    ShowMsg('Não existe uma configuração de conexão com o banco de dados.');
  end
  else if actOptions.Visible and not FDatabaseConfig.Exists then
  begin
    ShowMsg('É necessário selecionar uma conexão com o banco de dados.');
  end
  else if actRegister.Visible then
  begin
    ShowMsg('Registre um domínio para ter acesso ao sistema.');
  end
  else if actConnect.Visible and not actConnect.Enabled then
  begin
    ShowMsg('O acesso ao sistema está temporariamente indisponável.');
  end;
end;

initialization
begin
  RegisterFormType(TfrmLogin);
end;

end.




