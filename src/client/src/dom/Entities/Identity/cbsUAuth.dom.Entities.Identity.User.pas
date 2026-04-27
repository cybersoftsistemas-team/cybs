unit cbsUAuth.dom.Entities.Identity.User;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.User;

type
  TUser = class(TInterfacedObject, IUser)
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
    constructor Create(const ASettings: IUserSettings); overload;
    destructor Destroy; override;
    function IsEmpty: Boolean;
    function IsLocked: Boolean;
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

{ TUser }

constructor TUser.Create;
begin
  inherited Create;
  FId := TGUID.Empty;
  FSettingList := CreateUserSettingList;
end;

constructor TUser.Create(const ASettings: IUserSettings);
begin
  Create;
  if Assigned(ASettings) then
  begin
    FSettingList.AddRange(ASettings);
  end;
end;

destructor TUser.Destroy;
begin
  FSettingList.Clear;
  FSettingList := nil;
  inherited;
end;

function TUser.GetAccessFailedCount: Integer;
begin
  Result := FAccessFailedCount;
end;

function TUser.GetAccountActivated: Boolean;
begin
  Result := FAccountActivated;
end;

function TUser.GetAccountBlockedOut: Boolean;
begin
  Result := FAccountBlockedOut;
end;

function TUser.GetHash: TBytes;
begin
  Result := FHash;
end;

function TUser.GetId: TGuid;
begin
  Result := FId;
end;

function TUser.GetIterations: Integer;
begin
  Result := FIterations;
end;

function TUser.GetLastLoginAt: TDateTime;
begin
  Result := FLastLoginAt;
end;

function TUser.GetLockoutEnd: TDateTime;
begin
  Result := FLockoutEnd;
end;

function TUser.GetName: string;
begin
  Result := FName;
end;

function TUser.GetSalt: TBytes;
begin
  Result := FSalt;
end;

function TUser.GetSettings: IUserSettings;
begin
  Result := FSettingList;
end;

function TUser.IsEmpty: Boolean;
begin
  Result := Id = TGuid.Empty
end;

function TUser.IsLocked: Boolean;
begin
  Result := (LockoutEnd > Now);
end;

procedure TUser.SetAccessFailedCount(const AValue: Integer);
begin
  FAccessFailedCount := AValue;
end;

procedure TUser.SetAccountActivated(const AValue: Boolean);
begin
  FAccountActivated := AValue;
end;

procedure TUser.SetAccountBlockedOut(const AValue: Boolean);
begin
  FAccountBlockedOut := AValue;
end;

procedure TUser.SetHash(const AValue: TBytes);
begin
  FHash := AValue;
end;

procedure TUser.SetId(const AValue: TGuid);
begin
  FId := AValue;
end;

procedure TUser.SetIterations(const AValue: Integer);
begin
  FIterations := AValue;
end;

procedure TUser.SetLastLoginAt(const AValue: TDateTime);
begin
  FLastLoginAt := AValue;
end;

procedure TUser.SetLockoutEnd(const AValue: TDateTime);
begin
  FLockoutEnd := AValue;
end;

procedure TUser.SetName(const AValue: string);
begin
  FName := AValue;
end;

procedure TUser.SetSalt(const AValue: TBytes);
begin
  FSalt := AValue;
end;

end.
