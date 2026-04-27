unit cbsUAuth.dom.Contracts.Repositories.Identity.UserRepository;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.User;

type
  IUserRepository = interface(IUnknown)
    ['{6B7B80C6-8F31-4717-B565-37245DC247D2}']
    function GetById(const AId: TGuid): IUser;
    function GetByUserName(const AUserName: string): IUser;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure LockUser(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);
    procedure UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes);
  end;

implementation

end.
