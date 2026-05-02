unit cbsUAuth.dom.Exceptions.AuthError;

interface

type
  TAuthError = (
    aeNone,
    aeInvalidCredentials,
    aeUserNotFound,
    aeAccountNotActivated,
    aeAccountLocked
  );

implementation

end.
