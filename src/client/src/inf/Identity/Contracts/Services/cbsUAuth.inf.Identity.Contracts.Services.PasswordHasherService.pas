unit cbsUAuth.inf.Identity.Contracts.Services.PasswordHasherService;

interface

uses
{IDE}
  System.SysUtils;

type
  IIdentityPasswordHasherService = interface(IUnknown)
    ['{629C5CE9-3E36-4FD8-8241-145C38B5D58A}']
    function GenerateSalt: TBytes;
    function Hash(const APassword: string; const ASalt: TBytes; const AIterations: Integer): TBytes;
    function Verify(const APassword: string; const AHash: TBytes; const ASalt: TBytes; const AIterations: Integer): Boolean;
  end;

implementation

end.
