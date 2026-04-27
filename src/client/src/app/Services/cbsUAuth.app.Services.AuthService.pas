unit cbsUAuth.app.Services.AuthService;

interface

uses
{PROJECT}
  cbsUAuth.dom.Contracts.Repositories.Identity.ConfigRepository,
  cbsUAuth.dom.Contracts.Repositories.Identity.UserRepository,
  cbsUAuth.dom.Contracts.Services.AuthService,
  cbsUAuth.dom.Contracts.Services.PasswordHasher;

type
  TAuthService = class(TInterfacedObject, IAuthService)
  private
    FConfigRepository: IConfigRepository;
    FHasher: IPasswordHasher;
    FUserRepository: IUserRepository;
    function ValidatePasswordPolicy(const APassword: string): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function Authenticate(const AUserName, APassword: string; out AError: string): Boolean;
    function ChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword: string): Boolean;
    procedure TryCreateAdminWithTemporaryPassword(const AUserName, ATempPassword: string);
  end;

implementation

uses
{IDE}
  System.DateUtils,
  System.Math,
  System.SysUtils,
{PROJECT}
  cbsUAuth.app.Services.AuthError,
  cbsUAuth.inf.Repositories.Identity.ConfigRepository,
  cbsUAuth.inf.Repositories.Identity.UserRepository,
  cbsUAuth.inf.Services.PasswordHasher;

{ TAuthService }

constructor TAuthService.Create;
begin
  inherited Create;
  FConfigRepository := TConfigRepository.Create;
  FHasher := TPasswordHasher.Create;
  FUserRepository := TUserRepository.Create;
end;

destructor TAuthService.Destroy;
begin
  FHasher := nil;
  FUserRepository := nil;
  FConfigRepository := nil;
  inherited;
end;

function TAuthService.Authenticate(const AUserName, APassword: string; out AError: string): Boolean;
begin
  AError := '';
  Result := False;
  var LLockoutMinutes := FConfigRepository.LockoutMinutes;
  var LMaxAttempts := FConfigRepository.MaxAttempts;
  var LUser := FUserRepository.GetByUserName(AUserName);
  if LUser.IsEmpty then
  begin
    AError := AuthErrorMessage(aeInvalidCredentials);
    Exit;
  end;
  if not LUser.AccountActivated then
  begin
    AError := AuthErrorMessage(aeAccountNotActivated);
    Exit;
  end;
  if LUser.IsLocked then
  begin
    var LMinutes := Ceil((LUser.LockoutEnd - Now) * 24 * 60);
    AError := Format(AuthErrorMessage(aeAccountLocked), [LMinutes]);
    Exit;
  end;
  if FHasher.Verify(APassword, LUser.Hash, LUser.Salt, LUser.Iterations) then
  begin
    FUserRepository.ResetFailed(LUser.Id);
    Exit(True);
  end;
  var LNewFailed := LUser.AccessFailedCount;
  if LNewFailed >= LMaxAttempts then
  begin
    AError := Format(AuthErrorMessage(aeAccountLocked), [LLockoutMinutes]);
    Exit;
  end;
  FUserRepository.IncrementFailed(LUser.Id);
  AError := AuthErrorMessage(aeInvalidCredentials);
end;

function TAuthService.ChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword: string): Boolean;
begin
  Result := False;
  var LUser := FUserRepository.GetById(AUserId);
  if LUser.IsEmpty then Exit;
  if not FHasher.Verify(ACurrentPassword, LUser.Hash, LUser.Salt, LUser.Iterations) then Exit;
  if not ValidatePasswordPolicy(ANewPassword) then
  begin
    raise Exception.Create('Senha inválida');
  end;
  var LNewSalt := FHasher.GenerateSalt;
  var LNewHash := FHasher.Hash(ANewPassword, LNewSalt, LUser.Iterations);
  FUserRepository.UpdatePassword(LUser.Id, LNewHash, LNewSalt);
  Result := True;
end;

function TAuthService.ValidatePasswordPolicy(const APassword: string): Boolean;
const
  LChArray: array[0..9] of Char = ('0','1','2','3','4','5','6','7','8','9');
begin
  Result := (Length(APassword) >= 8) and
    (APassword.ToLower <> APassword) and
    (APassword.ToUpper <> APassword) and
    (APassword.IndexOfAny(LChArray) >= 0);
end;

procedure TAuthService.TryCreateAdminWithTemporaryPassword(const AUserName, ATempPassword: string);
begin
  var LUser := FUserRepository.GetByUserName(AUserName);
  if not LUser.IsEmpty and (LUser.LastLoginAt = 0) then
  begin
    var LIterations := LUser.Iterations;
    var LSalt := FHasher.GenerateSalt;
    var LHash := FHasher.Hash(ATempPassword, LSalt, LIterations);
    FUserRepository.UpdatePassword(LUser.Id, LHash, LSalt);
  end;
end;

end.
