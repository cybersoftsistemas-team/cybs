unit cbsUAuth.dom.Contracts.Entities.Identity.UserOption;

interface

type
  IUserOption = interface(IUnknown)
    ['{29BE24AE-34C6-42CB-98B2-DC00FB98BD94}']
    function GetId: TGuid;
    function GetName: string;
    function GetDescription: string;
    function GetChecked: Boolean;
    procedure SetId(const AValue: TGuid);
    procedure SetName(const AValue: string);
    procedure SetDescription(const AValue: string);
    procedure SetChecked(const AValue: Boolean);
    property Id: TGuid read GetId write SetId;
    property Name: string read GetName write SetName;
    property Description: string read GetDescription write SetDescription;
    property Checked: Boolean read GetChecked write SetChecked;
  end;

implementation

end.
