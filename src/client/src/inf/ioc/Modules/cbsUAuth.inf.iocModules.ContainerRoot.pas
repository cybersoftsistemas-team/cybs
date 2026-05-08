unit cbsUAuth.inf.iocModules.ContainerRoot;

interface

uses
{PROJECT}
  // Repositories...
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityConfigRepository,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository,
  // Services...
  cbsUAuth.app.Identity.Contracts.Services.UserAuthService,
  cbsUAuth.app.Identity.Contracts.Services.UserPasswordService,
  cbsUAuth.app.Identity.Contracts.Services.UserTemporaryPasswordService,
  cbsUAuth.inf.Identity.Contracts.Services.PasswordHasherService;

implementation

uses
{PROJECT}
  cbsSystem.Support.Container.RegisterType,
  // Repositories...
  cbsUAuth.inf.Identity.Repositories.IdentityConfigRepository,
  cbsUAuth.inf.Identity.Repositories.IdentityUserRepository,
  // Services...
  cbsUAuth.app.Identity.Services.UserAuthService,
  cbsUAuth.app.Identity.Services.UserPasswordService,
  cbsUAuth.app.Identity.Services.UserTemporaryPasswordService,
  cbsUAuth.inf.Identity.Services.PasswordHasherService;

initialization
begin
  // Repositories...
  BindIf(IIdentityConfigRepository, TIdentityConfigRepository);
  BindIf(IIdentityUserRepository, TIdentityUserRepository);
  // Services...
  BindIf(IIdentityPasswordHasherService, TIdentityPasswordHasherService);
  BindIf(IIdentityUserAuthService, TIdentityUserAuthService);
  BindIf(IIdentityUserPasswordService, TIdentityUserPasswordService);
  BindIf(IIdentityUserTemporaryPasswordService, TIdentityUserTemporaryPasswordService);
end;

end.






