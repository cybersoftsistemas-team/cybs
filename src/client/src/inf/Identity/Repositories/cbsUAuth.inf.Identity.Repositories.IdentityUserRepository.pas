unit cbsUAuth.inf.Identity.Repositories.IdentityUserRepository;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMain.inf.Repository,
  cbsUAuth.inf.Identity.Contracts.Repositories.IdentityUserRepository,
  cbsUAuth.inf.Identity.Entities;

type
  TIdentityUserRepository = class(TRepository<TIdentityUserEntity>, IIdentityUserRepository)
  public
    function Find(const AId: TGuid): TIdentityUserEntity; overload;
    function Find(const AName: string): TIdentityUserEntity; overload;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);
    procedure UpdatePassword(const AUserId: TGuid; const AHash: TBytes; const ASalt: TBytes; const AIterations: Integer; const AChangePasswordOnNextLogin: Boolean);
  end;

implementation

uses
{IDE}
  System.DateUtils,
  System.Rtti,
{PROJECT}
  cbsUAuth.dom.Identity.Common.SystemOptions,
{SPRING}
  Spring,
  Spring.Persistence.Criteria.Restrictions;

{ TIdentityUserRepository }

function TIdentityUserRepository.Find(const AId: TGuid): TIdentityUserEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('Id', TValue.From(AId))).ToList);
end;

function TIdentityUserRepository.Find(const AName: string): TIdentityUserEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('Name', AName)).ToList);
end;

procedure TIdentityUserRepository.IncrementFailed(const AUserId: TGuid);
begin
  var LUser := Session.FindOne<TIdentityUserEntity>(ToValue(AUserId));
  if not Assigned(LUser) then
    Exit;
  if LUser.LockoutEnd.HasValue and (LUser.LockoutEnd.Value > Now) then
    Exit;
  LUser.AccessFailedCount := LUser.AccessFailedCount + 1;
  var LConfig := Session.FindOne<TIdentityConfigEntity>(1);
  if Assigned(LConfig) and (LUser.AccessFailedCount >= LConfig.MaxAttempts) then
  begin
    LUser.LockoutEnd := IncMinute(Now, LConfig.LockoutMinutes);
  end;
  Session.Save(LUser);
end;

procedure TIdentityUserRepository.ResetFailed(const AUserId: TGuid);
begin
  var LUser := Session.FindOne<TIdentityUserEntity>(ToValue(AUserId));
  if not Assigned(LUser) then
    Exit;
  var LChanged := (LUser.AccessFailedCount <> 0)
    or LUser.LockoutEnd.HasValue
    or not LUser.LastLoginAt.HasValue;
  if not LChanged then
    Exit;
  LUser.AccessFailedCount := 0;
  LUser.LastLoginAt := Now;
  LUser.LockoutEnd := Default(Nullable<TDateTime>);
  Session.Save(LUser);
end;

procedure TIdentityUserRepository.UpdatePassword(
  const AUserId: TGuid;
  const AHash: TBytes;
  const ASalt: TBytes;
  const AIterations: Integer;
  const AChangePasswordOnNextLogin: Boolean
);
begin
  var LUserId := ToValue(AUserId);
  var LPasswordEntity := Session.FindOne<TIdentityPasswordEntity>(LUserId);
  if not Assigned(LPasswordEntity) then
    LPasswordEntity := TIdentityPasswordEntity.Create;
  LPasswordEntity.UserId := AUserId;
  LPasswordEntity.Hash := AHash;
  LPasswordEntity.Salt := ASalt;
  LPasswordEntity.Iterations := AIterations;
  Session.Save(LPasswordEntity);
  var LChangePasswordOnNextLoginId := ToValue(TSystemOptions.ChangePasswordOnNextLoginId);
  var LSetting := Session.CreateCriteria<TIdentitySettingEntity>
    .Add(Restrictions.Eq('UserId', LUserId))
    .Add(Restrictions.Eq('OptionId', LChangePasswordOnNextLoginId))
     .ToList
      .FirstOrDefault;
  if LSetting.Checked <> AChangePasswordOnNextLogin then
  begin
    LSetting.Checked := AChangePasswordOnNextLogin;
    Session.Save(LSetting);
  end;
end;

end.
