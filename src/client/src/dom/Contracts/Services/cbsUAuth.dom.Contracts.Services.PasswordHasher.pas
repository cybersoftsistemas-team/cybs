unit cbsUAuth.dom.Contracts.Services.PasswordHasher;

interface

uses
{IDE}
  System.SysUtils;

type
  IPasswordHasher = interface(IUnknown)
    ['{629C5CE9-3E36-4FD8-8241-145C38B5D58A}']
    function GenerateSalt: TBytes;
    function Hash(const APassword: string; const ASalt: TBytes; AIterations: Integer): TBytes;
    function Verify(const APassword: string; const AHash, ASalt: TBytes; AIterations: Integer): Boolean;
  end;

implementation

end.
