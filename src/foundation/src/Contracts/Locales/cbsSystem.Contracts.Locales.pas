unit cbsSystem.Contracts.Locales;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Locales.LocaleProperties,
  cbsSystem.Locales.Locale,
{SPRING}
  Spring.Collections;

type
  ILocaleEnumerator = IEnumerator<ILocaleProperties>;

  ILocales = interface(IUnknown)
    ['{E07FFE58-A42C-4501-ABFC-CEB685AB0FFF}']
    function AsLocale(const AValue: string; const AReturnFirstWhenNotFound: Boolean = True): TLocale;
    function Contains(const ALocale: TLocale): Boolean;
    function GetEnumerator: ILocaleEnumerator;
  end;

  ILocaleList = IList<ILocaleProperties>;

  function CreateLocaleList: ILocaleList;

implementation

function CreateLocaleList: ILocaleList;
begin
  Result := TCollections.CreateInterfaceList<ILocaleProperties>;
end;

end.
