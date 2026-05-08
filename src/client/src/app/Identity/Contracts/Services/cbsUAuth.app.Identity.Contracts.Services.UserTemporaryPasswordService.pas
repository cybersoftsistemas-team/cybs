unit cbsUAuth.app.Identity.Contracts.Services.UserTemporaryPasswordService;

interface

uses
{PROJECT}
  cbsUAuth.app.Identity.Contracts.Services.CustomUserPasswordService;

type
  IIdentityUserTemporaryPasswordService = interface(ICustomIdentityUserPasswordService)
    ['{18564AE1-3FA9-4C95-9187-8789BCF8BA3B}']
    procedure Update(const AUserId: TGuid; const ATemporaryPassword: string);
  end;

implementation

end.
