unit cbsUAuth.app.Common.AuthResult;

interface

uses
{PROJECT}
  cbsMain.app.Common.Result,
  cbsSystem.Contracts.MessageBag,
  cbsUAuth.dom.Exceptions.AuthError,
  cbsUAuth.inf.Identity.Entities;

type
  TAuthResult = TResult<TIdentityUserEntity, TAuthError>;
  TChangePasswordResult = TActionResult<IMessageBag>;

implementation

end.
