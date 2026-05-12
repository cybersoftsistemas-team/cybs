unit Identity.App.Services.UserAuthService;

interface

uses
{PROJECT}
  Identity.App.Contracts.Services.UserAuthService,
  Identity.App.Common.AuthResult,
  Identity.Inf.Contracts.Repositories.UserRepository,
  Identity.Inf.Contracts.Services.PasswordHasherService,
  Shared.Core.Services.Service;

type
  TUserAuthService = class(TService, IUserAuthService)
  private
    FPasswordHasherService: IPasswordHasherService;
    FUserRepository: IUserRepository;
  public

    constructor Create(
      const APasswordHasherService: IPasswordHasherService;
      const AUserRepository: IUserRepository
    );
    
    destructor Destroy; override;
    function Authenticate(const AUserName, APassword: string): TUserAuthResult;
  end;

implementation

uses
{PROJECT}
  cbsSystem.Support.Container,
  Identity.Dom.Exceptions.UserAuthError;

{ TUserAuthService }

constructor TUserAuthService.Create(
  const APasswordHasherService: IPasswordHasherService;
  const AUserRepository: IUserRepository
);
begin
  inherited Create;
  FPasswordHasherService := APasswordHasherService;
  FUserRepository := AUserRepository;
end;

destructor TUserAuthService.Destroy;
begin
  App.Release(FPasswordHasherService);
  App.Release(FUserRepository);
  inherited;
end;

function TUserAuthService.Authenticate(const AUserName, APassword: string): TUserAuthResult;
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

initialization
begin
  RegisterService(IUserAuthService, TUserAuthService);
end;

end.
