unit Identity.App.Services.CustomUserPasswordService;

interface

uses
{PROJECT}
  Identity.App.Contracts.Services.CustomUserPasswordService,
  Identity.Inf.Contracts.Repositories.ConfigRepository,
  Identity.Inf.Contracts.Repositories.UserRepository,
  Identity.Inf.Contracts.Services.PasswordHasherService,
  Shared.Core.Services.Service;

type
  TCustomUserPasswordService = class(TService, ICustomUserPasswordService)
  private
    FConfigRepository: IConfigRepository;
    FPasswordHasherService: IPasswordHasherService;
    FUserRepository: IUserRepository;
  protected

    constructor Create(
      const AConfigRepository: IConfigRepository;
      const APasswordHasherService: IPasswordHasherService;
      const AUserRepository: IUserRepository
    );

    procedure UpdatePassword(
      const AUserId: TGuid;
      const APassword: string;
      const AChangePasswordOnNextLogin: Boolean
    );

    property ConfigRepository: IConfigRepository read FConfigRepository;
    property PasswordHasherService: IPasswordHasherService read FPasswordHasherService;
    property UserRepository: IUserRepository read FUserRepository;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TCustomUserPasswordService }

constructor TCustomUserPasswordService.Create(
  const AConfigRepository: IConfigRepository;
  const APasswordHasherService: IPasswordHasherService;
  const AUserRepository: IUserRepository
);
begin
  inherited Create;
  FConfigRepository := AConfigRepository;
  FPasswordHasherService := APasswordHasherService;
  FUserRepository := AUserRepository;
end;

procedure TCustomUserPasswordService.UpdatePassword(
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
      AChangePasswordOnNextLogin // O usu rio deve alterar a senha no pr ximo logon
    );
  finally
    FreeAndNil(LConfig)
  end;
end;

end.

