unit cbsUAuth.app.Services.AuthError;

interface

uses
{PROJECT}
  cbsUAuth.dom.Exceptions.AuthError;

  function AuthErrorToMessage(const AError: TAuthError): string;

implementation

function AuthErrorToMessage(const AError: TAuthError): string;
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
