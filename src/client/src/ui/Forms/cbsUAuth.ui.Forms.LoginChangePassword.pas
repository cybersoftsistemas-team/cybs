unit cbsUAuth.ui.Forms.LoginChangePassword;

interface

uses
{PROJECT}
  cbsSystem.Form.DialogBaseForm,
{IDE}
  uniGUITypes, uniGUIBaseClasses, uniImageList, System.ImageList, Vcl.ImgList, System.Classes, System.Actions, Vcl.ActnList, uniMainMenu, cbsSystem.Form.BaseForm, uniGUIClasses,
  uniPanel, Vcl.Controls, Vcl.Forms, uniButton, uniBitBtn, uniLabel, uniEdit, uniImage;

type
  TfrmLoginChangePassword = class(TfrmDialogBase)
    pnlLcp: TUniContainerPanel;
    labStep03Title: TUniLabel;
    labStep03SubTitle: TUniLabel;
    pnlBreakTop2: TUniPanel;
    edtCurrentPassword: TUniEdit;
    edtNewPassword: TUniEdit;
    edtConfirmPassword: TUniEdit;
    pnlMsg: TUniSimplePanel;
    labMsg: TUniLabel;
    imgMsg: TUniImage;
    procedure actOkExecute(Sender: TObject);
    procedure UniFormCreate(Sender: TObject);
  private
    FUserId: TGuid;
  public
    property UserId: TGuid read FUserId write FUserId;
  end;

  function frmLoginChangePassword: TfrmLoginChangePassword;

implementation

{$R *.dfm}

uses
{IDE}
  System.UITypes,
{PROJECT}
  cbsMain.ui.Data.Modules.MainModule,
  cbsSystem.Support.Container,
  cbsUAuth.dom.Contracts.Services.AuthService;

function frmLoginChangePassword: TfrmLoginChangePassword;
begin
  Result := TfrmLoginChangePassword(damMain.GetFormInstance(TfrmLoginChangePassword));
end;

{ TfrmLoginChangePassword }

procedure TfrmLoginChangePassword.actOkExecute(Sender: TObject);
begin
  if not ValidateRequiredFields then Exit;
  var LActionResult := App.Make<IAuthService>.ChangePassword(
    FUserId
   ,edtCurrentPassword.Text
   ,edtNewPassword.Text
   ,edtConfirmPassword.Text
  );
  if not LActionResult.IsSuccess then
  begin
    edtCurrentPassword.Clear;
    edtNewPassword.Clear;
    edtConfirmPassword.Clear;
    MessageBox('Erro', 'Erro ao alterar a senha do próximo logon.', LActionResult.Value.Messages, mtError, [mbOK],
      procedure(const AResult: Integer)
      begin
        edtCurrentPassword.SetFocus;
      end);
    Exit;
  end;
  MessageDlg('A senha foi alterada com sucesso.', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK],
    procedure(Sender: TComponent; Result: Integer)
    begin
      inherited;
    end);
end;

procedure TfrmLoginChangePassword.UniFormCreate(Sender: TObject);
begin
  inherited;
  RegisterRequiredField(edtCurrentPassword);
  RegisterRequiredField(edtNewPassword);
  RegisterRequiredField(edtConfirmPassword);
end;

end.
