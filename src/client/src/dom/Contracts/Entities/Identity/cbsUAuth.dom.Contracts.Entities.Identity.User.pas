unit cbsUAuth.dom.Contracts.Entities.Identity.User;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsUAuth.dom.Contracts.Entities.Identity.UserOption,
{SPRING}
  Spring.Collections;

type
  IUserSettings = IEnumerable<IUserOption>;

  IUser = interface(IUnknown)
    ['{27235237-7179-49B1-86AE-79A00394B95D}']
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
    function IsEmpty: Boolean;
    function IsLocked: Boolean;
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

  IUserSettingList = IList<IUserOption>;

  function CreateUserSettingList: IUserSettingList;

implementation

function CreateUserSettingList: IUserSettingList;
begin
  Result := TCollections.CreateInterfaceList<IUserOption>;
end;

end.
