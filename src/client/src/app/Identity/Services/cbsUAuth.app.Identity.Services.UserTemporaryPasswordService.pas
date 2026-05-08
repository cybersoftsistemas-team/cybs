unit cbsUAuth.app.Identity.Services.UserTemporaryPasswordService;

interface

uses
{PROJECT}
  cbsUAuth.app.Identity.Contracts.Services.UserTemporaryPasswordService,
  cbsUAuth.app.Identity.Services.CustomUserPasswordService,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityConfigRepository,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository,
  cbsUAuth.inf.Identity.Contracts.Services.PasswordHasherService;

type
  TIdentityUserTemporaryPasswordService = class(TCustomIdentityUserPasswordService, IIdentityUserTemporaryPasswordService)
  public

    constructor Create(
      const AConfigRepository: IIdentityConfigRepository;
      const APasswordHasherService: IIdentityPasswordHasherService;
      const AUserRepository: IIdentityUserRepository
    );

    procedure Update(const AUserId: TGuid; const ATemporaryPassword: string);
  end;

implementation

{ TIdentityUserTemporaryPasswordService }

constructor TIdentityUserTemporaryPasswordService.Create(
  const AConfigRepository: IIdentityConfigRepository;
  const APasswordHasherService: IIdentityPasswordHasherService;
  const AUserRepository: IIdentityUserRepository
);
begin
  inherited Create(AConfigRepository, APasswordHasherService, AUserRepository);
end;

procedure TIdentityUserTemporaryPasswordService.Update(const AUserId: TGuid; const ATemporaryPassword: string);
begin
  inherited UpdatePassword(AUserId, ATemporaryPassword, True);
end;

end.
