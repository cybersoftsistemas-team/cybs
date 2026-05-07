unit cbsUAuth.app.Services.AuthService;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag,
  cbsUAuth.app.Common.AuthResult,
  cbsUAuth.dom.Contracts.Services.AuthService;

type
  TAuthService = class(TInterfacedObject, IAuthService)
  private
    procedure BeforeChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword, APasswordConfirmation: string; var AMessages: IMessageBag);
    procedure OnChangePassword(const AUserId: TGuid; const APassword: string; const AChangePasswordOnNextLogin: Boolean; var AMessages: IMessageBag);
    procedure UpdatePassword(AUserId: TGuid; const APassword: string; const AChangePasswordOnNextLogin: Boolean = False; const AForce: Boolean = False);
  public
    function Authenticate(const AUserName, APassword: string): TAuthResult;
    function ChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword, APasswordConfirmation: string;
      const AChangePasswordOnNextLogin: Boolean = False): TChangePasswordResult;
    procedure TryCreateAdminWithTemporaryPassword;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.Validation.Rules.PasswordPolicy,
  cbsSystem.Support.Container,
  cbsUAuth.dom.Contracts.Services.PasswordHasher,
  cbsUAuth.dom.Identity.Common.SystemUsers,
  cbsUAuth.dom.Exceptions.AuthError,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityConfigRepository,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository,
  cbsUAuth.inf.Identity.Entities;

{ TAuthService }

function TAuthService.Authenticate(const AUserName, APassword: string): TAuthResult;
begin
  var LUserRep := App.Make<IIdentityUserRepository>;
  var LUser := LUserRep.Find(AUserName);
  if not Assigned(LUser) then
  begin
    Exit(TAuthResult.Fail(aeUserNotFound));
  end;
  if LUser.AccountBlockedOut then
  begin
    Exit(TAuthResult.Fail(LUser, aeAccountLocked));
  end;
  if not LUser.AccountActivated then
  begin
    Exit(TAuthResult.Fail(LUser, aeAccountNotActivated));
  end;
  var LHasher := App.Make<IPasswordHasher>;
  if not LHasher.Verify(APassword, LUser.Password.Hash, LUser.Password.Salt, LUser.Password.Iterations) then
  begin
    LUserRep.IncrementFailed(LUser.Id);
    Exit(TAuthResult.Fail(LUser, aeInvalidCredentials));
  end;
  LUserRep.ResetFailed(LUser.Id);
  Result := TAuthResult.Ok(LUser);
end;

function TAuthService.ChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword, APasswordConfirmation: string;
  const AChangePasswordOnNextLogin: Boolean): TChangePasswordResult;

  function ActionResult(const AMessages: IMessageBag): TChangePasswordResult;
  begin
    if not AMessages.IsEmpty then
    begin
      Exit(TChangePasswordResult.Fail(AMessages));
    end;
    Result := TChangePasswordResult.Ok(AMessages);
  end;

begin
  var LMessages := App.Make<IMessageBag>;
  try
    BeforeChangePassword(AUserId, ACurrentPassword, ANewPassword, APasswordConfirmation, LMessages);
    OnChangePassword(AUserId, ANewPassword, AChangePasswordOnNextLogin, LMessages);
    Result := ActionResult(LMessages);
  except
    on E: Exception do
    begin
      LMessages.Clear;
      LMessages.Add('Erro', E.Message);
      Result := TChangePasswordResult.Fail(LMessages);
    end;
  end;
end;

procedure TAuthService.BeforeChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword, APasswordConfirmation: string; var AMessages: IMessageBag);
begin
  var LUser := App.Make<IIdentityUserRepository>.Find(AUserId);
  if not Assigned(LUser) then
  begin
    AMessages.Add('password', 'user.notfound');
    Exit;
  end;
  try
    if not App.Make<IPasswordHasher>.Verify(
      ACurrentPassword,
      LUser.Password.Hash,
      LUser.Password.Salt,
      LUser.Password.Iterations
    ) then
    begin
      AMessages.Add('password', 'current_password');
    end;
    var LPasswordPolicy := App.Make<IPasswordPolicy>;
    if not LPasswordPolicy.Min(8).Letters.MixedCase.Numbers.Symbols.Passes('Nova senha', ANewPassword) then
    begin
      AMessages.AddRange(LPasswordPolicy.Messages);
    end;
    if not AnsiSameStr(ANewPassword, APasswordConfirmation) then
    begin
      AMessages.Add('password', 'confirmed', [['attribute', 'Nova senha']]);
    end;
  finally
    FreeAndNil(LUser);
  end;
end;

procedure TAuthService.OnChangePassword(const AUserId: TGuid; const APassword: string; const AChangePasswordOnNextLogin: Boolean; var AMessages: IMessageBag);
begin
  if not AMessages.IsEmpty then Exit;
  UpdatePassword(AUserId, APassword, AChangePasswordOnNextLogin, True);
end;

procedure TAuthService.TryCreateAdminWithTemporaryPassword;
begin
  var LUser := App.Make<IIdentityUserRepository>.Find(TSystemUsers.AdministratorId);
  try
    if Assigned(LUser) and not LUser.PasswordExists then
    begin
      UpdatePassword(LUser.Id, TSystemUsers.TemporaryPassword, True);
    end;
  finally
    FreeAndNil(LUser);
  end;
end;

procedure TAuthService.UpdatePassword(AUserId: TGuid; const APassword: string; const AChangePasswordOnNextLogin: Boolean = False; const AForce: Boolean = False);
begin
  var LUser: TIdentityUserEntity;
  var LUserRep := App.Make<IIdentityUserRepository>;
  if not AForce then
  begin
    LUser := LUserRep.Find(AUserId);
    try
      AUserId := LUser.Id;
    finally
      FreeAndNil(LUser);
    end;
  end;
  if not AUserId.IsEmpty then
  begin
    var LConfig := App.Make<IIdentityConfigRepository>.GetConfig;
    try
      var LIterations := LConfig.PasswordIterations;
      var LHasher := App.Make<IPasswordHasher>;
      var LSalt := LHasher.GenerateSalt;
      LUserRep.UpdatePassword(
        AUserId,
        LHasher.Hash(
          APassword,
          LSalt,
          LIterations
        ),
        LSalt,
        LIterations,
        AChangePasswordOnNextLogin // O usuário deve alterar a senha no próximo logon
      );
    finally
      FreeAndNil(LConfig)
    end;
  end;
end;

end.
