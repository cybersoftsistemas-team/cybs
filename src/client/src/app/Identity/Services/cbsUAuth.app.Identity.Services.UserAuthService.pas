unit cbsUAuth.app.Identity.Services.UserAuthService;

interface

uses
{PROJECT}
  cbsUAuth.app.Identity.Common.AuthResult,
  cbsUAuth.app.Identity.Contracts.Services.UserAuthService,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository,
  cbsUAuth.inf.Identity.Contracts.Services.PasswordHasherService;

type
  TIdentityUserAuthService = class(TInterfacedObject, IIdentityUserAuthService)
  private
    FPasswordHasherService: IIdentityPasswordHasherService;
    FUserRepository: IIdentityUserRepository;
  public
    constructor Create(
      const APasswordHasherService: IIdentityPasswordHasherService;
      const AUserRepository: IIdentityUserRepository
    );
    destructor Destroy; override;
    function Authenticate(const AUserName, APassword: string): TUserAuthResult;
  end;

implementation

uses
{PROJECT}
  cbsSystem.Support.Container,
  cbsUAuth.dom.Identity.Exceptions.UserAuthError;

{ TIdentityUserAuthService }

constructor TIdentityUserAuthService.Create(
  const APasswordHasherService: IIdentityPasswordHasherService;
  const AUserRepository: IIdentityUserRepository
);
begin
  inherited Create;
  FPasswordHasherService := APasswordHasherService;
  FUserRepository := AUserRepository;
end;

destructor TIdentityUserAuthService.Destroy;
begin
  App.Release(FPasswordHasherService);
  App.Release(FUserRepository);
  inherited;
end;

function TIdentityUserAuthService.Authenticate(const AUserName, APassword: string): TUserAuthResult;
begin
  var LUser := FUserRepository.Find(AUserName);
  if not Assigned(LUser) then
  begin
    Exit(TUserAuthResult.Fail(aeUserNotFound));
  end;
  if LUser.AccountBlockedOut then
  begin
    Exit(TUserAuthResult.Fail(LUser, aeAccountLocked));
  end;
  if not LUser.AccountActivated then
  begin
    Exit(TUserAuthResult.Fail(LUser, aeAccountNotActivated));
  end;
  if not FPasswordHasherService.Verify(
    APassword,
    LUser.Password.Hash,
    LUser.Password.Salt,
    LUser.Password.Iterations
  ) then
  begin
    FUserRepository.IncrementFailed(LUser.Id);
    Exit(TUserAuthResult.Fail(LUser, aeInvalidCredentials));
  end;
  FUserRepository.ResetFailed(LUser.Id);
  Result := TUserAuthResult.Ok(LUser);
end;

end.

