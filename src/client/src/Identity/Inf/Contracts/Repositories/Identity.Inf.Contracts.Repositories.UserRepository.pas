unit Identity.Inf.Contracts.Repositories.UserRepository;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  Identity.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  IUserRepository = interface(IRepository<TUserEntity>)
    ['{024D61E6-F50C-495C-8CF8-94525647B6B5}']
    function Find(const AId: TGuid): TUserEntity; overload;
    function Find(const AName: string): TUserEntity; overload;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);
    procedure UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes; const AIterations: Integer; const AChangePasswordOnNextLogin: Boolean);
  end;

implementation

end.

