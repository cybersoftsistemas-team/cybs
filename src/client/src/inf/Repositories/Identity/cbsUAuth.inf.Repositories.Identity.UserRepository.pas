unit cbsUAuth.inf.Repositories.Identity.UserRepository;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.User,
  cbsUAuth.dom.Contracts.Repositories.Identity.UserRepository;

type
  TIdentityUserRepository = class(TInterfacedObject, IIdentityUserRepository)
  public
    function GetById(const AId: TGuid): IIdentityUser;
    function GetByUserName(const AUserName: string): IIdentityUser;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);
    procedure UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes; const AIterations: Integer; const AChangePasswordOnNextLogin: Boolean = False);
  end;

implementation

uses
{PROJECT}
  cbsSystem.Support.Container,
  cbsUAuth.dom.Entities.Identity.User,
  cbsUAuth.inf.Repositories.DataModules.Identity.damIdentityUser;

{ TIdentityUserRepository }

function TIdentityUserRepository.GetById(const AId: TGuid): IIdentityUser;
begin
  var LDataModule := App.Make<TdamIdentityUser>;
  try
    Result := LDataModule.GetById(AId);
  finally
    App.Release(LDataModule);
  end;
end;

function TIdentityUserRepository.GetByUserName(const AUserName: string): IIdentityUser;
begin
  var LDataModule := App.Make<TdamIdentityUser>;
  try
    Result := LDataModule.GetByUserName(AUserName);
  finally
    App.Release(LDataModule);
  end;
end;

procedure TIdentityUserRepository.IncrementFailed(const AUserId: TGuid);
begin
  var LDataModule := App.Make<TdamIdentityUser>;
  try
    LDataModule.IncrementFailed(AUserId);
  finally
    App.Release(LDataModule);
  end;
end;

procedure TIdentityUserRepository.ResetFailed(const AUserId: TGuid);
begin
  var LDataModule := App.Make<TdamIdentityUser>;
  try
    LDataModule.ResetFailed(AUserId);
  finally
    App.Release(LDataModule);
  end;
end;

procedure TIdentityUserRepository.UpdatePassword(const AUserId: TGuid; const AHash, ASalt: TBytes; const AIterations: Integer; const AChangePasswordOnNextLogin: Boolean);
begin
  var LDataModule := App.Make<TdamIdentityUser>;
  try
    LDataModule.UpdatePassword(AUserId,  AHash, ASalt, AIterations, AChangePasswordOnNextLogin);
  finally
    App.Release(LDataModule);
  end;
end;

end.



