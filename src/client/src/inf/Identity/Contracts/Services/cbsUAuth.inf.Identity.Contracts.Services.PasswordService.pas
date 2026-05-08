unit cbsUAuth.inf.Identity.Contracts.Services.PasswordService;

interface

uses
{IDE}
  System.SysUtils;

type
  IPasswordService = interface(IUnknown)
    ['{DFF093A5-922B-4B02-A35C-08E4FEC42734}']
    function Verify(
      const APassword: string;
      const AHash: TBytes;
      const ASalt: TBytes;
      const AIterations: Integer
    ): Boolean;
  end;

implementation

end.
