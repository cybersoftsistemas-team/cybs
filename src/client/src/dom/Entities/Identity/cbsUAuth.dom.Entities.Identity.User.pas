unit cbsUAuth.dom.Entities.Identity.User;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.User,
  cbsUAuth.dom.Contracts.Entities.Identity.UserOption;

type
  TIdentityUser = class(TInterfacedObject, IIdentityUser)
  private
    FAccessFailedCount: Integer;
    FAccountActivated: Boolean;
    FAccountBlockedOut: Boolean;
    FHash: TBytes;
    FId: TGuid;
    FIterations: Integer;
    FLastLoginAt: TDateTime;
    FLockoutEnd: TDateTime;
    FName: string;
    FPasswordExists: Boolean;
    FSalt: TBytes;
    FSettingList: IUserSettingList;
    function GetAccessFailedCount: Integer;
    function GetAccountActivated: Boolean;
    function GetAccountBlockedOut: Boolean;
    function GetHash: TBytes;
    function GetId: TGuid;
    function GetIterations: Integer;
    function GetLastLoginAt: TDateTime;
    function GetLockoutEnd: TDateTime;
    function GetName: string;
    function GetSalt: TBytes;
    function GetSettings: IUserSettings;
    procedure SetAccessFailedCount(const AValue: Integer);
    procedure SetAccountActivated(const AValue: Boolean);
    procedure SetAccountBlockedOut(const AValue: Boolean);
    procedure SetHash(const AValue: TBytes);
    procedure SetId(const AValue: TGuid);
    procedure SetIterations(const AValue: Integer);
    procedure SetLastLoginAt(const AValue: TDateTime);
    procedure SetLockoutEnd(const AValue: TDateTime);
    procedure SetName(const AValue: string);
    procedure SetSalt(const AValue: TBytes);
  public
    constructor Create; overload;
    constructor Create(const ASettings: TArray<IIdentityUserOption>); overload;
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function IsLocked: Boolean;
    function IsPasswordExists: Boolean;
    property AccessFailedCount: Integer read GetAccessFailedCount write SetAccessFailedCount;
    property AccountActivated: Boolean read GetAccountActivated write SetAccountActivated;
    property AccountBlockedOut: Boolean read GetAccountBlockedOut write SetAccountBlockedOut;
    property Hash: TBytes read GetHash write SetHash;
    property Id: TGuid read GetId write SetId;
    property Iterations: Integer read GetIterations write SetIterations;
    property LastLoginAt: TDateTime read GetLastLoginAt write SetLastLoginAt;
    property LockoutEnd: TDateTime read GetLockoutEnd write SetLockoutEnd;
    property Name: string read GetName write SetName;
    property Salt: TBytes read GetSalt write SetSalt;
    property Settings: IUserSettings read GetSettings;
  end;

implementation

{ TIdentityUser }

constructor TIdentityUser.Create;
begin
  inherited Create;
  FId := TGUID.Empty;
  FSettingList := CreateUserSettingList;
end;

constructor TIdentityUser.Create(const ASettings: TArray<IIdentityUserOption>);
begin
  Create;
  if Assigned(ASettings) then
  begin
    FSettingList.AddRange(ASettings);
  end;
end;

destructor TIdentityUser.Destroy;
begin
  FSettingList.Clear;
  FSettingList := nil;
  inherited;
end;

function TIdentityUser.GetAccessFailedCount: Integer;
begin
  Result := FAccessFailedCount;
end;

function TIdentityUser.GetAccountActivated: Boolean;
begin
  Result := FAccountActivated;
end;

function TIdentityUser.GetAccountBlockedOut: Boolean;
begin
  Result := FAccountBlockedOut;
end;

function TIdentityUser.GetHash: TBytes;
begin
  Result := FHash;
end;

function TIdentityUser.GetId: TGuid;
begin
  Result := FId;
end;

function TIdentityUser.GetIterations: Integer;
begin
  Result := FIterations;
end;

function TIdentityUser.GetLastLoginAt: TDateTime;
begin
  Result := FLastLoginAt;
end;

function TIdentityUser.GetLockoutEnd: TDateTime;
begin
  Result := FLockoutEnd;
end;

function TIdentityUser.GetName: string;
begin
  Result := FName;
end;

function TIdentityUser.GetSalt: TBytes;
begin
  Result := FSalt;
end;

function TIdentityUser.GetSettings: IUserSettings;
begin
  Result := FSettingList;
end;

function TIdentityUser.IsEmpty: Boolean;
begin
  Result := Id = TGuid.Empty
end;

function TIdentityUser.IsLocked: Boolean;
begin
  Result := (LockoutEnd > Now);
end;

function TIdentityUser.IsPasswordExists: Boolean;
begin
  Result := FPasswordExists;
end;

procedure TIdentityUser.SetAccessFailedCount(const AValue: Integer);
begin
  FAccessFailedCount := AValue;
end;

procedure TIdentityUser.SetAccountActivated(const AValue: Boolean);
begin
  FAccountActivated := AValue;
end;

procedure TIdentityUser.SetAccountBlockedOut(const AValue: Boolean);
begin
  FAccountBlockedOut := AValue;
end;

procedure TIdentityUser.SetHash(const AValue: TBytes);
begin
  FHash := AValue;
  FPasswordExists := Length(FHash) > 0;
end;

procedure TIdentityUser.SetId(const AValue: TGuid);
begin
  FId := AValue;
end;

procedure TIdentityUser.SetIterations(const AValue: Integer);
begin
  FIterations := AValue;
end;

procedure TIdentityUser.SetLastLoginAt(const AValue: TDateTime);
begin
  FLastLoginAt := AValue;
end;

procedure TIdentityUser.SetLockoutEnd(const AValue: TDateTime);
begin
  FLockoutEnd := AValue;
end;

procedure TIdentityUser.SetName(const AValue: string);
begin
  FName := AValue;
end;

procedure TIdentityUser.SetSalt(const AValue: TBytes);
begin
  FSalt := AValue;
end;

end.
