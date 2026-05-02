unit cbsSystem.Locales.LocaleProperties;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Locales.LocaleProperties,
  cbsSystem.Locales.Locale;

type
  TLocaleProperties = class(TInterfacedObject, ILocaleProperties)
  private
    FCode: string;
    FIcon: string;
    FLabel: string;
    function GetCode: string;
    function GetIcon: string;
    function GetLabel: string;
    procedure SetCode(const AValue: string);
    procedure SetIcon(const AValue: string);
    procedure SetLabel(const AValue: string);
  public
    constructor Create(const ACode: TLocale; const AIcon, ALabel: string);
    property Code: string read GetCode write SetCode;
    property Icon: string read GetIcon write SetIcon;
    property &Label: string read GetLabel write SetLabel;
  end;

implementation

{ TLocaleProperties }

constructor TLocaleProperties.Create(const ACode: TLocale; const AIcon, ALabel: string);
begin
  inherited Create;
  FCode := ACode.ToString;
  FIcon := AIcon;
  FLabel := ALabel;
end;

function TLocaleProperties.GetCode: string;
begin
  Result := FCode;
end;

function TLocaleProperties.GetIcon: string;
begin
  Result := FIcon;
end;

function TLocaleProperties.GetLabel: string;
begin
  Result := FLabel;
end;

procedure TLocaleProperties.SetCode(const AValue: string);
begin
  FCode := AValue;
end;

procedure TLocaleProperties.SetIcon(const AValue: string);
begin
  FIcon := AValue;
end;

procedure TLocaleProperties.SetLabel(const AValue: string);
begin
  FLabel := AValue;
end;

end.
