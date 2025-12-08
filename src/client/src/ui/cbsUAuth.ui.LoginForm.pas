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
    btnConnect: TUniBitBtn;
    btnDomains: TUniSpeedButton;
    btnOptions: TUniBitBtn;
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
    pnlFooter: TUniSimplePanel;
    pnlHeader: TUniSimplePanel;
    tmrDomains: TUniTimer;
    procedure actConnectExecute(Sender: TObject);
    procedure actDomainsExecute(Sender: TObject);
    procedure actOptionsExecute(Sender: TObject);
    procedure tmrDomainsTimer(Sender: TObject);
    procedure UniLoginFormActivate(Sender: TObject);
    procedure UniLoginFormAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
    procedure UniLoginFormCreate(Sender: TObject);
  private
    procedure SetBtnDomainsEnabled;
  end;

  function frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
  uniGUIApplication,
{PROJECT}
  cbsSystem.Contracts.Module.Main,
  cbsSystem.Support.Form,
  cbsSystem.Support.RunTime,
  cbsSystem.Support.ServerModule,
  cbsUAuth.data.module.LoginModule,
  cbsUAuth.ui.DomainsForm,
  cbsUAuth.ui.OptionsForm;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(UniApplication.UniMainModule.GetFormInstance(TfrmLogin));
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
  frmOptions.ShowModal;
end;

procedure TfrmLogin.SetBtnDomainsEnabled;
begin
  actDomains.Enabled := not ServerModule.Database.Id.IsEmpty;
end;

procedure TfrmLogin.tmrDomainsTimer(Sender: TObject);
begin
  SetBtnDomainsEnabled;
  if actDomains.Enabled then
  begin
    tmrDomains.Enabled := False;
  end;
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
  SetBtnDomainsEnabled;
  if not actDomains.Enabled then
  begin
    tmrDomains.Enabled := True;
  end;
  actOptions.Visible := RunTime.IsClientRunningInServer;
  if not actOptions.Visible then
  begin
    btnConnect.Left := btnDomains.Left - btnConnect.Width + btnDomains.Width;
  end;
end;

initialization
begin
  RegisterFormClass(TfrmLogin);
end;

end.
