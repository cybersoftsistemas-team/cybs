unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniButton, uniBitBtn, uniGUIBaseClasses, uniEdit;

type
  TfrmLogin = class(TUniForm)
    edtUser: TUniEdit;
    edtPass: TUniEdit;
    UniBitBtn1: TUniBitBtn;
  private
    { Private declarations }
  public
    procedure ValidateLogin;
  end;

function frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication;

function frmLogin: TfrmLogin;
begin
  Result := TfrmLogin(UniMainModule.GetFormInstance(TfrmLogin));
end;

{ TfrmLogin }

procedure TfrmLogin.ValidateLogin;
begin
  if (edtUser.Text = '') or (edtPass.Text = '') then
  begin
    ShowMessage('Informe o usuário e senha.');
    Exit;
  end;

  if (SameText(edtUser.Text, 'admin')) and (edtPass.Text = '1234') then
  begin
    UniMainModule.UserName := edtUser.Text;
    Hide; // oculta login
    UniApplication.ShowForm(TMainForm); // abre tela principal
  end
  else
    ShowMessage('Usuário ou senha inválidos.');
end;

end.
