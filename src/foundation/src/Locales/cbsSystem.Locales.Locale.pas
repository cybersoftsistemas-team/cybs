unit cbsSystem.Locales.Locale;

interface

type
{$SCOPEDENUMS ON}
  TLocale = (en, pt_br);
{$SCOPEDENUMS OFF}

  TLocaleExtensions = record Helper for TLocale
  public
    function ToString: string;
  end;

implementation

uses
{IDE}
  System.Rtti;

{ TLocaleExtensions }

function TLocaleExtensions.ToString: string;
begin
  Result := TRttiEnumerationType.GetName(Self);
end;

end.
