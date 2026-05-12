unit Identity.App.Contracts.Services.UserPasswordService;

interface

uses
{PROJECT}
  Identity.App.Common.AuthResult,
  Identity.App.Contracts.Services.CustomUserPasswordService;

type
  IUserPasswordService = interface(ICustomUserPasswordService)
    ['{3D65E2FA-4BF7-4F40-9210-979C804A3613}']
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