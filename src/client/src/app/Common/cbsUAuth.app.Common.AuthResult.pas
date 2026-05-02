unit cbsUAuth.app.Common.AuthResult;

interface

uses
{PROJECT}
  cbsMain.app.Common.Result,
  cbsUAuth.dom.Contracts.Entities.Identity.User,
  cbsUAuth.dom.Exceptions.AuthError;

type
  TAuthResult = TResult<IIdentityUser, TAuthError>;

implementation

end.
