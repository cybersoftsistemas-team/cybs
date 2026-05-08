unit cbsUAuth.app.Identity.Common.UserAuthError;

interface

uses
{PROJECT}
  cbsUAuth.dom.Identity.Exceptions.UserAuthError;

  function UserAuthErrorToMessage(const AError: TUserAuthError): string;

implementation

function UserAuthErrorToMessage(const AError: TUserAuthError): string;
begin
  case AError of
    aeInvalidCredentials,
    aeUserNotFound:
      Result := 'Usuário não encontrado ou a senha está inválida.';
    aeAccountNotActivated:
      Result := 'Conta desativada.';
    aeAccountLocked:
      Result := 'Conta bloqueada. Entre novamente em %d minuto(s).';
  end;
end;

end.
