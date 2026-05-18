unit Identity.App.Common.AuthResult;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag,
  Identity.Dom.Exceptions.UserAuthError,
  Identity.Inf.Entities,
  Shared.Core.Common.ActionResult,
  Shared.Core.Common.Result;

type
  TUserAuthResult = TResult<TUserEntity, TUserAuthError>;
  TChangePasswordResult = TActionResult<IMessageBag>;

implementation

end.

