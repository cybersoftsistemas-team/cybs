unit cbsUAuth.inf.Repositories.Identity.UserRepository;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.User,
  cbsUAuth.dom.Contracts.Repositories.Identity.UserRepository;

type
  TUserRepository = class(TInterfacedObject, IUserRepository)
  public
    function GetById(const AId: TGuid): IUser;
    function GetByUserName(const AUserName: string): IUser;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure LockUser(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);
    procedure UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes);
  end;

implementation

uses
{PROJECT}
  cbsUAuth.dom.Entities.Identity.User,
  cbsUAuth.inf.Repositories.Identity.Data.Modules.damUser;

{ TUserRepository }

function TUserRepository.GetById(const AId: TGuid): IUser;
begin
  var LdamUser := TdamUser.Create(nil);
  try
    Result := LdamUser.GetById(AId);
  finally
    FreeAndNil(LdamUser);
  end;
end;

function TUserRepository.GetByUserName(const AUserName: string): IUser;
begin
  var LdamUser := TdamUser.Create(nil);
  try
    Result := LdamUser.GetByUserName(AUserName);
  finally
    FreeAndNil(LdamUser);
  end;
end;

procedure TUserRepository.IncrementFailed(const AUserId: TGuid);
begin
  var LdamUser := TdamUser.Create(nil);
  try
    LdamUser.IncrementFailed(AUserId);
  finally
    FreeAndNil(LdamUser);
  end;
end;

procedure TUserRepository.LockUser(const AUserId: TGuid);
begin
  var LdamUser := TdamUser.Create(nil);
  try
    LdamUser.LockUser(AUserId);
  finally
    FreeAndNil(LdamUser);
  end;
end;

procedure TUserRepository.ResetFailed(const AUserId: TGuid);
begin
  var LdamUser := TdamUser.Create(nil);
  try
    LdamUser.ResetFailed(AUserId);
  finally
    FreeAndNil(LdamUser);
  end;
end;

procedure TUserRepository.UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes);
begin
  var LdamUser := TdamUser.Create(nil);
  try
    LdamUser.UpdatePassword(AUserId,  AHash, ASalt);
  finally
    FreeAndNil(LdamUser);
  end;
end;

end.
