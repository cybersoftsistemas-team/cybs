unit cbsUAuth.app.Services.AuthService;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag,
  cbsUAuth.app.Common.AuthResult,
  cbsUAuth.dom.Contracts.Services.AuthService;

type
  TAuthService = class(TInterfacedObject, IAuthService)
  public
    function Authenticate(const AUserName, APassword: string): TAuthResult;
    function ChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword: string; out AMessages: IMessageBag;
      const AChangePasswordOnNextLogin: Boolean = False): Boolean;
    procedure TryCreateAdminWithTemporaryPassword;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.Validation.Rules.PasswordPolicy,
  cbsSystem.Support.Container,
  cbsUAuth.app.Services.AuthError,
  cbsUAuth.dom.Common.Identity.SystemUsers,
  cbsUAuth.dom.Contracts.Repositories.Identity.ConfigRepository,
  cbsUAuth.dom.Contracts.Repositories.Identity.UserRepository,
  cbsUAuth.dom.Contracts.Services.PasswordHasher,
  cbsUAuth.dom.Exceptions.AuthError;

{ TAuthService }

function TAuthService.Authenticate(const AUserName, APassword: string): TAuthResult;
begin
  var LUserRep := App.Make<IIdentityUserRepository>;
  var LUser := LUserRep.GetByUserName(AUserName);
  if LUser.IsEmpty then
  begin
    Exit(TAuthResult.Fail(LUser, aeUserNotFound));
  end;
  if LUser.IsLocked then
  begin
    Exit(TAuthResult.Fail(LUser, aeAccountLocked));
  end;
  if not LUser.AccountActivated then
  begin
    Exit(TAuthResult.Fail(LUser, aeAccountNotActivated));
  end;
  var LHasher := App.Make<IPasswordHasher>;
  if not LHasher.Verify(APassword, LUser.Hash, LUser.Salt, LUser.Iterations) then
  begin
    LUserRep.IncrementFailed(LUser.Id);
    Exit(TAuthResult.Fail(LUser, aeInvalidCredentials));
  end;
  LUserRep.ResetFailed(LUser.Id);
  Result := TAuthResult.Ok(LUser);
end;

function TAuthService.ChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword: string; out AMessages: IMessageBag;
  const AChangePasswordOnNextLogin: Boolean): Boolean;
begin
  Result := False;
  AMessages := App.Make<IMessageBag>;
  var LUserRep := App.Make<IIdentityUserRepository>;
  var LUser := LUserRep.GetById(AUserId);
  if LUser.IsEmpty then Exit;
  var LHasher := App.Make<IPasswordHasher>;
  if not LHasher.Verify(ACurrentPassword, LUser.Hash, LUser.Salt, LUser.Iterations) then
  begin
    AMessages.Add('password', 'current_password');
  end;
  var LPasswordPolicy := App.Make<IPasswordPolicy>;
  if not LPasswordPolicy.Min(8).Letters.MixedCase.Numbers.Symbols.Passes('Nova senha', ANewPassword) then
  begin
    AMessages.AddRange(LPasswordPolicy.Messages);
  end;
  if not AMessages.IsEmpty then Exit;
  var LConfigRep := App.Make<IIdentityConfigRepository>;
  var LIterations := LConfigRep.PasswordIterations;
  var LNewSalt := LHasher.GenerateSalt;
  LUserRep.UpdatePassword(
    LUser.Id,
    LHasher.Hash(
      ANewPassword,
      LNewSalt,
      LIterations
    ),
    LNewSalt,
    LIterations,
    AChangePasswordOnNextLogin // O usuário deve alterar a senha no próximo logon
  );
  Result := True;
end;

procedure TAuthService.TryCreateAdminWithTemporaryPassword;
begin
  var LUserRep := App.Make<IIdentityUserRepository>;
  var LUser := LUserRep.GetById(TSystemUsers.AdministratorId);
  if not LUser.IsEmpty and not LUser.IsPasswordExists then
  begin
    var LConfigRep := App.Make<IIdentityConfigRepository>;
    var LIterations := LConfigRep.PasswordIterations;
    var LHasher := App.Make<IPasswordHasher>;
    var LSalt := LHasher.GenerateSalt;
    LUserRep.UpdatePassword(
      LUser.Id,
      LHasher.Hash(
        TSystemUsers.TemporaryPassword,
        LSalt,
        LIterations
      ),
      LSalt,
      LIterations,
      True // O usuário deve alterar a senha no próximo logon
    );
  end;
end;

end.
