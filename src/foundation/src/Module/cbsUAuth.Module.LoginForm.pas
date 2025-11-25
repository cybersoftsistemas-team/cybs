unit cbsUAuth.Module.LoginForm;

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
    actDomains: TAction;
    pnlAuthenticate: TUniPanel;
    pnlHeader: TUniSimplePanel;
    UniLabel3: TUniLabel;
    UniLabel4: TUniLabel;
    UniLabel5: TUniLabel;
    UniLabel6: TUniLabel;
    pnlBody: TUniSimplePanel;
    edtUserName: TUniDBEdit;
    edtPassword: TUniDBEdit;
    edtDomainName: TUniDBEdit;
    btnConnect: TUniBitBtn;
    btnDomains: TUniSpeedButton;
    pnlFooter: TUniSimplePanel;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    nilstMain: TUniNativeImageList;
    UniImage1: TUniImage;
    procedure UniLoginFormCreate(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure UniLoginFormActivate(Sender: TObject);
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
  System.SysUtils,
{PROJECT}
  cbsServer.Cybersoft.MainModule,
  cbsServer.Support.Form,
  cbsServer.Support.RunTime,
  cbsUAuth.Module.LoginModule;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(damMainModule.GetFormInstance(TfrmLogin));
end;

{ TfrmLogin }

procedure TfrmLogin.UniLoginFormCreate(Sender: TObject);
begin
//  actOptions.Visible := RunTime.IsClientRunningInServer;
//  if not actOptions.Visible then
//  begin
//    btnConnect.Left := btnDomains.Left - btnConnect.Width + btnDomains.Width;
//  end;
end;

procedure TfrmLogin.actConnectExecute(Sender: TObject);
begin
  ModalResult := mrOK;
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
