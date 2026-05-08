unit cbsUAuth.app.Identity.Services.CustomUserPasswordService;

interface

uses
{PROJECT}
  cbsUAuth.app.Identity.Contracts.Services.CustomUserPasswordService,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityConfigRepository,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository,
  cbsUAuth.inf.Identity.Contracts.Services.PasswordHasherService;

type
  TCustomIdentityUserPasswordService = class(TInterfacedObject, ICustomIdentityUserPasswordService)
  private
    FConfigRepository: IIdentityConfigRepository;
    FPasswordHasherService: IIdentityPasswordHasherService;
    FUserRepository: IIdentityUserRepository;
  protected

    constructor Create(
      const AConfigRepository: IIdentityConfigRepository;
      const APasswordHasherService: IIdentityPasswordHasherService;
      const AUserRepository: IIdentityUserRepository
    );

    procedure UpdatePassword(
      const AUserId: TGuid;
      const APassword: string;
      const AChangePasswordOnNextLogin: Boolean
    );

    property ConfigRepository: IIdentityConfigRepository read FConfigRepository;
    property PasswordHasherService: IIdentityPasswordHasherService read FPasswordHasherService;
    property UserRepository: IIdentityUserRepository read FUserRepository;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TCustomIdentityUserPasswordService }

constructor TCustomIdentityUserPasswordService.Create(
  const AConfigRepository: IIdentityConfigRepository;
  const APasswordHasherService: IIdentityPasswordHasherService;
  const AUserRepository: IIdentityUserRepository
);
begin
  inherited Create;
  FConfigRepository := AConfigRepository;
  FPasswordHasherService := APasswordHasherService;
  FUserRepository := AUserRepository;
end;

procedure TCustomIdentityUserPasswordService.UpdatePassword(
  const AUserId: TGuid;
  const APassword: string;
  const AChangePasswordOnNextLogin: Boolean
);
begin
  if AUserId.IsEmpty then Exit;
  var LConfig := FConfigRepository.GetConfig;
  try
    var LIterations := LConfig.PasswordIterations;
    var LSalt := FPasswordHasherService.GenerateSalt;
    FUserRepository.UpdatePassword(
      AUserId,
      FPasswordHasherService.Hash(
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

end.
