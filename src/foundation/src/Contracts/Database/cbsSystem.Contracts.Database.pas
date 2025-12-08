unit cbsSystem.Contracts.Database;

interface

type
  IcbsDatabase = interface(IUnknown)
    ['{7A0C9AF5-5E45-4BDC-9CF0-8826F7B2C003}']
    function GetConnectionName: string;
    function GetConnectionString: string;
    function GetId: TGuid;
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure Clear;
    procedure EndUpdate;
    procedure ExecuteMigrations;
    procedure SetConnectionName(const AValue: string);
    procedure SetConnectionString(const AValue: string);
    procedure SetId(const AValue: TGuid);
    property ConnectionName: string read GetConnectionName write SetConnectionName;
    property ConnectionString: string read GetConnectionString write SetConnectionString;
    property Id: TGuid read GetId write SetId;
  end;

implementation

end.
