unit Identity.App.Common.UserAuthError;

interface

uses
{PROJECT}
  Identity.Dom.Exceptions.UserAuthError;

  function UserAuthErrorToMessage(const AError: TUserAuthError): string;

implementation

function UserAuthErrorToMessage(const AError: TUserAuthError): string;
begin
  case AError of
    aeInvalidCredentials,
    aeUserNotFound:
      Result := 'Usu�rio n�o encontrado ou a senha est� inv�lida.';
    aeAccountNotActivated:
      Result := 'Conta desativada.';
    aeAccountLocked:
      Result := 'Conta bloqueada. Entre novamente em %d minuto(s).';
  end;
end;

end.