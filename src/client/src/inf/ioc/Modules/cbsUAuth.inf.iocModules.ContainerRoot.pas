unit cbsUAuth.inf.iocModules.ContainerRoot;

interface

uses
{PROJECT}
  // Entities...
  cbsUAuth.dom.Contracts.Entities.Identity.Config,
  cbsUAuth.dom.Contracts.Entities.Identity.User,
  cbsUAuth.dom.Contracts.Entities.Identity.UserOption,
  // Repositories...
  cbsUAuth.dom.Contracts.Repositories.Identity.ConfigRepository,
  cbsUAuth.dom.Contracts.Repositories.Identity.UserRepository,
  // Services...
  cbsUAuth.dom.Contracts.Services.AuthService,
  cbsUAuth.dom.Contracts.Services.PasswordHasher;

implementation

uses
{PROJECT}
  cbsSystem.Support.Container.RegisterType,
  // DataModules...
  cbsUAuth.inf.Repositories.DataModules.Identity.damIdentityConfig,
  cbsUAuth.inf.Repositories.DataModules.Identity.damIdentityUser,
  // Entities...
  cbsUAuth.dom.Entities.Identity.Config,
  cbsUAuth.dom.Entities.Identity.User,
  cbsUAuth.dom.Entities.Identity.UserOption,
  // Repositories...
  cbsUAuth.inf.Repositories.Identity.ConfigRepository,
  cbsUAuth.inf.Repositories.Identity.UserRepository,
  // Services...
  cbsUAuth.app.Services.AuthService,
  cbsUAuth.inf.Services.PasswordHasher;

initialization
begin
  // DataModules...
  BindIf(TdamIdentityConfig);
  BindIf(TdamIdentityUser);
  // Entities...
  BindIf(IIdentityConfig, TIdentityConfig);
  BindIf(IIdentityUser, TIdentityUser);
  BindIf(IIdentityUserOption, TIdentityUserOption);
  // Repositories...
  BindIf(IIdentityConfigRepository, TIdentityConfigRepository);
  BindIf(IIdentityUserRepository, TIdentityUserRepository);
  // Services...
  BindIf(IAuthService, TAuthService);
  BindIf(IPasswordHasher, TPasswordHasher);
end;

end.






