unit cbsUAuth.dom.Identity.Exceptions.UserAuthError;

interface

type
  TUserAuthError = (
    aeNone,
    aeInvalidCredentials,
    aeUserNotFound,
    aeAccountNotActivated,
    aeAccountLocked
  );

implementation

end.
