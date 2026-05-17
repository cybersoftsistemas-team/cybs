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
      Result := 'Usuário não encontrado ou a senha está incorreta.';
    aeAccountNotActivated:
      Result := 'Conta desativada.';
    aeAccountLocked:
      Result := 'Conta bloqueada. Entre novamente em %d minuto(s).';
  end;
end;

end.