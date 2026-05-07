unit cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMain.dom.Contracts.Repository,
  cbsUAuth.inf.Identity.Entities;

type
  IIdentityUserRepository = interface(IRepository<TIdentityUserEntity>)
    ['{8F5DCCA0-2FB0-4C6B-A4CD-A2C3AD09358E}']
    function Find(const AId: TGuid): TIdentityUserEntity; overload;
    function Find(const AName: string): TIdentityUserEntity; overload;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);
    procedure UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes; const AIterations: Integer; const AChangePasswordOnNextLogin: Boolean);
  end;

implementation

end.
