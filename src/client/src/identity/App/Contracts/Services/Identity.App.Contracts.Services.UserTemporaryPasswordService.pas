unit Identity.App.Contracts.Services.UserTemporaryPasswordService;

interface

uses
{PROJECT}
  Identity.App.Contracts.Services.CustomUserPasswordService;

type
  IUserTemporaryPasswordService = interface(ICustomUserPasswordService)
    ['{450333A7-4B9B-4539-BEDF-E7A797C6383C}']
    procedure Update(const AUserId: TGuid; const ATemporaryPassword: string);
  end;

implementation

end.