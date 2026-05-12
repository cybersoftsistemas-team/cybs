unit Identity.App.Services.UserTemporaryPasswordService;

interface

uses
{PROJECT}
  Identity.App.Contracts.Services.UserTemporaryPasswordService,
  Identity.App.Services.CustomUserPasswordService,
  Identity.Inf.Contracts.Repositories.ConfigRepository,
  Identity.Inf.Contracts.Repositories.UserRepository,
  Identity.Inf.Contracts.Services.PasswordHasherService;

type
  TUserTemporaryPasswordService = class(TCustomUserPasswordService, IUserTemporaryPasswordService)
  public

    constructor Create(
      const AConfigRepository: IConfigRepository;
      const APasswordHasherService: IPasswordHasherService;
      const AUserRepository: IUserRepository
    );

    procedure Update(const AUserId: TGuid; const ATemporaryPassword: string);
  end;

implementation

uses
{PROJECT}
  Shared.Core.Services.Service;

{ TUserTemporaryPasswordService }

constructor TUserTemporaryPasswordService.Create(
  const AConfigRepository: IConfigRepository;
  const APasswordHasherService: IPasswordHasherService;
  const AUserRepository: IUserRepository
);
begin
  inherited Create(AConfigRepository, APasswordHasherService, AUserRepository);
end;

procedure TUserTemporaryPasswordService.Update(const AUserId: TGuid; const ATemporaryPassword: string);
begin
  inherited UpdatePassword(AUserId, ATemporaryPassword, True);
end;

initialization
begin
  RegisterService(IUserTemporaryPasswordService, TUserTemporaryPasswordService);
end;

end.

