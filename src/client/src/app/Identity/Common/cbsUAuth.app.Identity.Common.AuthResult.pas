unit cbsUAuth.app.Identity.Common.AuthResult;

interface

uses
{PROJECT}
  cbsMain.app.Common.Result,
  cbsSystem.Contracts.MessageBag,
  cbsUAuth.dom.Identity.Exceptions.UserAuthError,
  cbsUAuth.inf.Identity.Entities;

type
  TUserAuthResult = TResult<TIdentityUserEntity, TUserAuthError>;
  TChangePasswordResult = TActionResult<IMessageBag>;

implementation

end.

