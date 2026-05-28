unit cbsSystem.Contracts.DatabaseConfig;

interface

type
  IDatabaseConfig = interface(IUnknown)
    ['{7A0C9AF5-5E45-4BDC-9CF0-8826F7B2C003}']
    function Exists: Boolean;
    function GetConnectionName: string;
    function GetConnectionString: string;
    function GetId: TGuid;
    procedure ApplyUpdates;
    procedure CancelUpdate;
    procedure Clear;
    procedure SetConnectionName(const AValue: string);
    procedure SetConnectionString(const AValue: string);
    procedure SetId(const AValue: TGuid);
    property ConnectionName: string read GetConnectionName write SetConnectionName;
    property ConnectionString: string read GetConnectionString write SetConnectionString;
    property Id: TGuid read GetId write SetId;
  end;

implementation

end.
