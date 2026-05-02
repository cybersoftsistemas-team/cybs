unit cbsSystem.Contracts.Locales.LocaleProperties;

interface

type
  ILocaleProperties = interface
    ['{B4B9CEDA-052A-4A8F-9427-AC5FE8CB890D}']
    function GetCode: string;
    function GetIcon: string;
    function GetLabel: string;
    procedure SetCode(const AValue: string);
    procedure SetIcon(const AValue: string);
    procedure SetLabel(const AValue: string);
    property Code: string read GetCode write SetCode;
    property Icon: string read GetIcon write SetIcon;
    property &Label: string read GetLabel write SetLabel;
  end;

implementation

end.
