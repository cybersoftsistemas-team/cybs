unit cbsUAuth.inf.Identity.Entities;

interface

uses
{PROJECT}
  cbsMain.inf.Entity,
{SPRING}
  Spring,
  Spring.Collections,
  Spring.Persistence.Mapping.Attributes;

type
  [Entity]
  [Table('[configs]', '[identity]')]
  TIdentityConfigEntity = class(TEntity)
  private
    FId: Integer;
    FLockoutMinutes: Integer;
    FMaxAttempts: Integer;
    FPasswordIterations: Integer;
  public
    [Column('Id', [cpPrimaryKey, cpRequired])]
    property Id: Integer read FId write FId;
    [Column('LockoutMinutes', [cpRequired])]
    property LockoutMinutes: Integer read FLockoutMinutes write FLockoutMinutes;
    [Column('MaxAttempts', [cpRequired])]
    property MaxAttempts: Integer read FMaxAttempts write FMaxAttempts;
    [Column('PasswordIterations', [cpRequired])]
    property PasswordIterations: Integer read FPasswordIterations write FPasswordIterations;
  end;

  [Entity]
  [Table('[options]', '[identity]')]
  TIdentityOptionEntity = class(TEntity)
  private
    FId: TGuid;
    FName: string;
    FDescription: string;
  public
    [Column('Id', [cpPrimaryKey, cpRequired])]
    property Id: TGuid read FId write FId;
    [Column('Name', [cpRequired])]
    property Name: string read FName write FName;
    [Column('Description', [cpRequired])]
    property Description: string read FDescription write FDescription;
  end;

  [Entity]
  [Table('[settings]', '[identity]')]
  TIdentitySettingEntity = class(TEntity)
  private
    FId: TGuid;
    FUserId: TGuid;
    FOptionId: TGuid;
    FChecked: Boolean;
  public
    [Column('Id', [cpPrimaryKey, cpRequired])]
    property Id: TGuid read FId write FId;
    [Column('UserId', [cpRequired])]
    [ForeignJoinColumn('UserId', '[identity].[users]', 'Id')]
    property UserId: TGuid read FUserId write FUserId;
    [Column('OptionId', [cpRequired])]
    property OptionId: TGuid read FOptionId write FOptionId;
    [Column('Checked', [cpRequired])]
    property Checked: Boolean read FChecked write FChecked;
  end;

  TIdentityUserEntity = class;

  [Entity]
  [Table('[passwords]', '[identity]')]
  TIdentityPasswordEntity = class(TEntity)
  private
    FUserId: TGuid;
    FHash: TBytes;
    FIterations: Integer;
    FSalt: TBytes;
  public
    [Column('UserId', [cpPrimaryKey, cpRequired])]
    [ForeignJoinColumn('UserId', '[identity].[users]', 'Id')]
    property UserId: TGuid read FUserId write FUserId;
    [Column('Hash', [cpRequired])]
    property Hash: TBytes read FHash write FHash;
    [Column('Iterations', [cpRequired])]
    property Iterations: Integer read FIterations write FIterations;
    [Column('Salt', [cpRequired])]
    property Salt: TBytes read FSalt write FSalt;
  end;

  [Entity]
  [Table('[users]', '[identity]')]
  TIdentityUserEntity = class(TEntity)
  private
    FId: TGuid;
    FName: string;
    FDescription: string;
    FAccessFailedCount: Integer;
    FAccountActivated: Boolean;
    FAccountBlockedOut: Boolean;
    FAccountExpired: Boolean;
    FAccountDisabled: Boolean;
    FAccountExpiresDate: Nullable<TDateTime>;
    FLastLoginAt: Nullable<TDateTime>;
    FLockoutEnd: Nullable<TDateTime>;
    FReserved: Boolean;
    FPersonId: Nullable<TGuid>;
  private
    [ManyToOne(False, [ckCascadeAll], 'Id')]
    FPassword: TIdentityPasswordEntity;
    [OneToMany(False, [ckCascadeAll])]
    FSettings: Lazy<IList<TIdentitySettingEntity>>;
  private
    function GetSettings: IList<TIdentitySettingEntity>;
  public
    function PasswordExists: Boolean;
    destructor Destroy; override;
  public
    [Column('Id', [cpPrimaryKey])]
    [ForeignJoinColumn('Id', '[identity].[passwords]', 'UserId')]
    property Id: TGuid read FId write FId;
    [Column('Name', [cpRequired])]
    property Name: string read FName write FName;
    [Column('Description', [cpRequired])]
    property Description: string read FDescription write FDescription;
    [Column('AccessFailedCount', [cpRequired])]
    property AccessFailedCount: Integer read FAccessFailedCount write FAccessFailedCount;
    [Column('AccountActivated', [cpDontInsert, cpDontUpdate])]
    property AccountActivated: Boolean read FAccountActivated write FAccountActivated;
    [Column('AccountBlockedOut', [cpDontInsert, cpDontUpdate])]
    property AccountBlockedOut: Boolean read FAccountBlockedOut write FAccountBlockedOut;
    [Column('AccountExpired', [cpDontInsert, cpDontUpdate])]
    property AccountExpired: Boolean read FAccountExpired write FAccountExpired;
    [Column('AccountDisabled')]
    property AccountDisabled: Boolean read FAccountDisabled write FAccountDisabled;
    [Column('AccountExpiresDate')]
    property AccountExpiresDate: Nullable<TDateTime> read FAccountExpiresDate write FAccountExpiresDate;
    [Column('LastLoginAt')]
    property LastLoginAt: Nullable<TDateTime> read FLastLoginAt write FLastLoginAt;
    [Column('LockoutEnd')]
    property LockoutEnd: Nullable<TDateTime> read FLockoutEnd write FLockoutEnd;
    [Column('Reserved', [cpRequired])]
    property Reserved: Boolean read FReserved write FReserved;
    [Column('PersonId')]
    property PersonId: Nullable<TGuid> read FPersonId write FPersonId;
  public
    property Password: TIdentityPasswordEntity read FPassword;
    property Settings: IList<TIdentitySettingEntity> read GetSettings;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TIdentityUserEntity }

destructor TIdentityUserEntity.Destroy;
begin
  FreeAndNil(FPassword);
  inherited;
end;

function TIdentityUserEntity.GetSettings: IList<TIdentitySettingEntity>;
begin
  Result := FSettings;
end;

function TIdentityUserEntity.PasswordExists: Boolean;
begin
  Result := Assigned(FPassword) and not FPassword.UserId.IsEmpty;
end;

end.
