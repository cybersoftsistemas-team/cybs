unit cbsUAuth.app.Identity.Contracts.Services.UserAuthService;

interface

uses
{PROJECT}
  cbsUAuth.app.Identity.Common.AuthResult;

type
  IIdentityUserAuthService = interface(IUnknown)
    ['{CD148D67-A0FF-44D0-85E6-C85FDE34252A}']
    function Authenticate(const AUserName, APassword: string): TUserAuthResult;
  end;

implementation

end.

