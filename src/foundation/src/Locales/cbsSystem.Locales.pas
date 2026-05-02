unit cbsSystem.Locales;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Locales,
  cbsSystem.Locales.Locale;

type
  TLocales = class(TInterfacedObject, ILocales)
  private
    FLocales: ILocaleList;
    procedure SetLocale(const ACode: TLocale; const AIcon, ALabel: string);
    procedure SetLocales;
  public
    constructor Create;
    destructor Destroy; override;
    function AsLocale(const AValue: string; const AReturnFirstWhenNotFound: Boolean = True): TLocale;
    function Contains(const ALocale: TLocale): Boolean;
    function GetEnumerator: ILocaleEnumerator;
  end;

implementation

uses
{IDE}
  System.Math,
  System.Rtti,
{PROJECT}
  cbsSystem.Contracts.Locales.LocaleProperties,
  cbsSystem.Locales.LocaleProperties;

{ TLocales }

constructor TLocales.Create;
begin
  inherited Create;
  FLocales := CreateLocaleList;
  SetLocales;
end;

destructor TLocales.Destroy;
begin
  FLocales.Clear;
  FLocales := nil;
  inherited;
end;

function TLocales.AsLocale(const AValue: string; const AReturnFirstWhenNotFound: Boolean): TLocale;
begin
  var LValue := ShortInt(TRttiEnumerationType.GetValue<TLocale>(AValue));
  if AReturnFirstWhenNotFound then
  begin
    LValue := Max(LValue, 0);
  end;
  Result := TLocale(LValue);
end;

function TLocales.Contains(const ALocale: TLocale): Boolean;
begin
  Result := Assigned(FLocales.SingleOrDefault(
    function(const AProp: ILocaleProperties): Boolean
    begin
      Result := AProp.Code = ALocale.ToString;
    end));
end;

function TLocales.GetEnumerator: ILocaleEnumerator;
begin
  Result := FLocales.GetEnumerator;
end;

procedure TLocales.SetLocale(const ACode: TLocale; const AIcon, ALabel: string);
begin
  if not Contains(ACode) then
  begin
    FLocales.Add(TLocaleProperties.Create(ACode, AIcon, ALabel));
  end;
end;

procedure TLocales.SetLocales;
begin
  SetLocale(TLocale.en   , 'us', 'English');
  SetLocale(TLocale.pt_br, 'br', 'Português (Brasil)');
end;

end.
