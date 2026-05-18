unit Identity.App.Services.UserPasswordService;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag,
  cbsSystem.Contracts.Validation.Rules.PasswordPolicy,
  Identity.App.Contracts.Services.UserPasswordService,
  Identity.App.Common.AuthResult,
  Identity.App.Services.CustomUserPasswordService,
  Identity.Inf.Contracts.Repositories.ConfigRepository,
  Identity.Inf.Contracts.Repositories.UserRepository,
  Identity.Inf.Contracts.Services.PasswordHasherService;

type
  TUserPasswordService = class(TCustomUserPasswordService, IUserPasswordService)
  private
    FMessages: IMessageBag;
    FPasswordPolicy: IPasswordPolicy;
    procedure BeforeChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword, APasswordConfirmation: string);
    procedure OnChangePassword(const AUserId: TGuid; const APassword: string; const AChangePasswordOnNextLogin: Boolean);
  public

    constructor Create(
      const AConfigRepository: IConfigRepository;
      const AMessages: IMessageBag;
      const APasswordHasherService: IPasswordHasherService;
      const APasswordPolicy: IPasswordPolicy;
      const AUserRepository: IUserRepository
    );

    function Change(
      const AUserId: TGuid;
      const ACurrentPassword: string;
      const ANewPassword: string;
      const APasswordConfirmation: string;
      const AChangePasswordOnNextLogin: Boolean = False
    ): TChangePasswordResult;

  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  Shared.Core.Services.Service;

{ TUserPasswordService }

constructor TUserPasswordService.Create(
  const AConfigRepository: IConfigRepository;
  const AMessages: IMessageBag;
  const APasswordHasherService: IPasswordHasherService;
  const APasswordPolicy: IPasswordPolicy;
  const AUserRepository: IUserRepository
);
begin
  inherited Create(AConfigRepository, APasswordHasherService, AUserRepository);
  FMessages := AMessages;
  FPasswordPolicy := APasswordPolicy;
end;

function TUserPasswordService.Change(
  const AUserId: TGuid;
  const ACurrentPassword: string;
  const ANewPassword: string;
  const APasswordConfirmation: string;
  const AChangePasswordOnNextLogin: Boolean = False
): TChangePasswordResult;

  function ActionResult: TChangePasswordResult;
  begin
    if not FMessages.IsEmpty then
    begin
      Exit(TChangePasswordResult.Fail(FMessages));
    end;
    Result := TChangePasswordResult.Ok(FMessages);
  end;

begin
  try
    BeforeChangePassword(AUserId, ACurrentPassword, ANewPassword, APasswordConfirmation);
    OnChangePassword(AUserId, ANewPassword, AChangePasswordOnNextLogin);
    Result := ActionResult;
  except
    on E: Exception do
    begin
      FMessages.Clear;
      FMessages.Add('Erro', E.Message);
      Result := TChangePasswordResult.Fail(FMessages);
    end;
  end;
end;

procedure TUserPasswordService.BeforeChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword, APasswordConfirmation: string);
begin
  var LUser := UserRepository.Find(AUserId);
  if not Assigned(LUser) then
  begin
    FMessages.Add('password', 'user.notfound');
    Exit;
  end;
  try
    if not PasswordHasherService.Verify(
      ACurrentPassword,
      LUser.Password.Hash,
      LUser.Password.Salt,
      LUser.Password.Iterations
    ) then
    begin
      FMessages.Add('password', 'current_password');
    end;
    if not FPasswordPolicy.Min(8).Letters.MixedCase.Numbers.Symbols.Passes('Nova senha', ANewPassword) then
    begin
      FMessages.AddRange(FPasswordPolicy.Messages);
    end;
    if not AnsiSameStr(ANewPassword, APasswordConfirmation) then
    begin
      FMessages.Add('password', 'confirmed', [['attribute', 'Nova senha']]);
    end;
  finally
    FreeAndNil(LUser);
  end;
end;

procedure TUserPasswordService.OnChangePassword(const AUserId: TGuid; const APassword: string; const AChangePasswordOnNextLogin: Boolean);
begin
  if not FMessages.IsEmpty then Exit;
  inherited UpdatePassword(AUserId, APassword, AChangePasswordOnNextLogin);
end;

initialization
begin
  RegisterService(IUserPasswordService, TUserPasswordService);
end;

end.

