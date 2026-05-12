unit Identity.App.Contracts.Services.UserAuthService;

interface

uses
{PROJECT}
  Identity.App.Common.AuthResult,
  Shared.Core.Contracts.Services.Service;

type
  IUserAuthService = interface(IService)
    ['{B03A738C-753C-4194-A5A9-97F67FB5825F}']
    function Authenticate(const AUserName, APassword: string): TUserAuthResult;
  end;

implementation

end.


