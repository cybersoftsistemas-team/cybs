unit cbsUAuth.dom.Contracts.Services.AuthService;

interface

uses
{PROJECT}
  cbsUAuth.app.Common.AuthResult;

type
  IAuthService = interface(IUnknown)
    ['{5226C4F7-E276-45C5-A16D-8D98763E50FA}']
    function Authenticate(const AUserName, APassword: string): TAuthResult;
    function ChangePassword(const AUserId: TGuid; const ACurrentPassword, ANewPassword, APasswordConfirmation: string;
      const AChangePasswordOnNextLogin: Boolean = False): TChangePasswordResult;
    procedure TryCreateAdminWithTemporaryPassword;
  end;

implementation

end.
