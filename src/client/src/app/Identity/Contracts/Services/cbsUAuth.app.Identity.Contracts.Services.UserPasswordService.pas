unit cbsUAuth.app.Identity.Contracts.Services.UserPasswordService;

interface

uses
{PROJECT}
  cbsUAuth.app.Identity.Common.AuthResult,
  cbsUAuth.app.Identity.Contracts.Services.CustomUserPasswordService;

type
  IIdentityUserPasswordService = interface(ICustomIdentityUserPasswordService)
    ['{245C51DE-B26A-4588-85F9-2C91E4791310}']
    function Change(
      const AUserId: TGuid;
      const ACurrentPassword: string;
      const ANewPassword: string;
      const APasswordConfirmation: string;
      const AChangePasswordOnNextLogin: Boolean = False
    ): TChangePasswordResult;
  end;

implementation

end.
