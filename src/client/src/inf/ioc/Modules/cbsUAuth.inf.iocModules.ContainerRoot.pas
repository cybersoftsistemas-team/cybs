unit cbsUAuth.inf.iocModules.ContainerRoot;

interface

uses
{PROJECT}
  // Repositories...
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityConfigRepository,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository,
  // Services...
  cbsUAuth.dom.Contracts.Services.AuthService,
  cbsUAuth.dom.Contracts.Services.PasswordHasher;

implementation

uses
{PROJECT}
  cbsSystem.Support.Container.RegisterType,
  // Entities...
  cbsUAuth.inf.Identity.Entities,
  // Repositories...
  cbsUAuth.inf.Identity.Repositories.IdentityConfigRepository,
  cbsUAuth.inf.Identity.Repositories.IdentityUserRepository,
  // Services...
  cbsUAuth.app.Services.AuthService,
  cbsUAuth.inf.Services.PasswordHasher;

initialization
begin
  // Entities...
  BindIf(TIdentityConfigEntity);
  BindIf(TIdentityUserEntity);
  // Repositories...
  BindIf(IIdentityConfigRepository, TIdentityConfigRepository);
  BindIf(IIdentityUserRepository, TIdentityUserRepository);
  // Services...
  BindIf(IAuthService, TAuthService);
  BindIf(IPasswordHasher, TPasswordHasher);
end;

end.






