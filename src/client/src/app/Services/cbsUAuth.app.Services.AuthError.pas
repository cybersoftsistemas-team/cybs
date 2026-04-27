unit cbsUAuth.app.Services.AuthError;

interface

type
  TAuthError = (
    aeInvalidCredentials,
    aeUserNotFound,
    aeAccountNotActivated,
    aeAccountLocked
  );

  function AuthErrorMessage(const AError: TAuthError): string;

implementation

function AuthErrorMessage(const AError: TAuthError): string;
begin
  case AError of
    aeInvalidCredentials,
    aeUserNotFound:
      Result := 'O usuário não foi encontrado ou a senha está inválida.';
    aeAccountNotActivated:
      Result := 'Conta desativada.';
    aeAccountLocked:
      Result := 'Conta bloqueada por tentativas de logon. Tente novamente em %d minuto(s).';
  end;
end;

end.
