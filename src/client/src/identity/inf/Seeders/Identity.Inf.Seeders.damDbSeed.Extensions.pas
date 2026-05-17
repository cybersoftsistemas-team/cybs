unit Identity.Inf.Seeders.damDbSeed.Extensions;

interface

uses
{PROJECT}
  Identity.Inf.Seeders.damDbSeed;

type
  TdamIdentityDbSeedExtensions = class helper for TdamIdentityDbSeed
  public
    procedure CreateAdminUser(const AId: TGuid; const AName: string; const ADescription: string);
    procedure CreateConfig;
    procedure CreateOption(const AId: TGuid; const AName: string; const ADescription: string);
    procedure CreateUserTemporaryPassword(const AUserId: TGuid; const ATemporaryPassword: string);
  end;

implementation

uses
{PROJECT}
  Identity.Inf.Entities;

{ TdamIdentityDbSeedExtensions }

procedure TdamIdentityDbSeedExtensions.CreateAdminUser(const AId: TGuid; const AName: string; const ADescription: string);
begin
  var LEntity := UserRepository.Find(AId);
  try
    if not Assigned(LEntity) then
      LEntity := TUserEntity.Create;
    LEntity.Id := AId;
    LEntity.Name := AName;
    LEntity.Description := ADescription;
    LEntity.Reserved := True;
    UserRepository.Save(LEntity);
  finally
    LEntity.Free;
  end;
end;

procedure TdamIdentityDbSeedExtensions.CreateConfig;
begin
  ConfigRepository.GetConfig.Free;
end;

procedure TdamIdentityDbSeedExtensions.CreateOption(const AId: TGuid; const AName, ADescription: string);
begin
  var LEntity := OptionRepository.Find(AId);
  try
    if not Assigned(LEntity) then
      LEntity := TOptionEntity.Create;
    LEntity.Id := AId;
    LEntity.Name := AName;
    LEntity.Description := ADescription;
    OptionRepository.Save(LEntity);
  finally
    LEntity.Free;
  end;
end;

procedure TdamIdentityDbSeedExtensions.CreateUserTemporaryPassword(const AUserId: TGuid; const ATemporaryPassword: string);
begin
  var LEntity := UserRepository.Find(AUserId);
  try
    if Assigned(LEntity) and not LEntity.PasswordExists then
    begin
      UserTemporaryPasswordService.Update(
        AUserId,
        ATemporaryPassword
      );
    end;
  finally
    LEntity.Free;
  end;
end;

end.
