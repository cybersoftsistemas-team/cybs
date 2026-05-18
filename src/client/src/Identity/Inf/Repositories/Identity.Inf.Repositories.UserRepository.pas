unit Identity.Inf.Repositories.UserRepository;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  Identity.Inf.Contracts.Repositories.UserRepository,
  Identity.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TUserRepository = class(TRepository<TUserEntity>, IUserRepository)
  public
    function Find(const AId: TGuid): TUserEntity; overload;
    function Find(const AName: string): TUserEntity; overload;
    procedure IncrementFailed(const AUserId: TGuid);
    procedure ResetFailed(const AUserId: TGuid);

    procedure UpdatePassword(
      const AUserId: TGuid;
      const AHash: TBytes;
      const ASalt: TBytes;
      const AIterations: Integer;
      const AChangePasswordOnNextLogin: Boolean
    );
  end;

implementation

uses
{IDE}
  System.DateUtils,
{PROJECT}
  Identity.Dom.Common.SystemOptions,
{SPRING}
  Spring;

{ TUserRepository }

function TUserRepository.Find(const AId: TGuid): TUserEntity;
begin
  Result := inherited Find(AId);
end;

function TUserRepository.Find(const AName: string): TUserEntity;
begin
  Result := inherited Find(AName);
end;

procedure TUserRepository.IncrementFailed(const AUserId: TGuid);
begin
  var LUser := Session.FindOne<TUserEntity>(ToValue(AUserId));
  if not Assigned(LUser) then
    Exit;
  if LUser.LockoutEnd.HasValue and (LUser.LockoutEnd.Value > Now) then
    Exit;
  LUser.AccessFailedCount := LUser.AccessFailedCount + 1;
  var LConfig := Session.FindOne<TConfigEntity>(1);
  if Assigned(LConfig) and (LUser.AccessFailedCount >= LConfig.MaxAttempts) then
  begin
    LUser.LockoutEnd := IncMinute(Now, LConfig.LockoutMinutes);
  end;
  Session.Save(LUser);
end;

procedure TUserRepository.ResetFailed(const AUserId: TGuid);
begin
  var LUser := Session.FindOne<TUserEntity>(ToValue(AUserId));
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

procedure TUserRepository.UpdatePassword(
  const AUserId: TGuid;
  const AHash: TBytes;
  const ASalt: TBytes;
  const AIterations: Integer;
  const AChangePasswordOnNextLogin: Boolean
);
begin
  var LUserId := ToValue(AUserId);
  var LPasswordEntity := Session.FindOne<TPasswordEntity>(LUserId);
  if not Assigned(LPasswordEntity) then
    LPasswordEntity := TPasswordEntity.Create;
  LPasswordEntity.UserId := AUserId;
  LPasswordEntity.Hash := AHash;
  LPasswordEntity.Salt := ASalt;
  LPasswordEntity.Iterations := AIterations;
  Session.Save(LPasswordEntity);
  var LChangePasswordOnNextLoginId := ToValue(TSystemOptions.ChangePasswordOnNextLoginId);
  var LSetting := Session.CreateCriteria<TSettingEntity>
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

initialization
begin
  RegisterRepository(IUserRepository, TUserRepository);
end;

end.

