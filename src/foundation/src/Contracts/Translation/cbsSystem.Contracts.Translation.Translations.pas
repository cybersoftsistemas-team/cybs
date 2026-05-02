unit cbsSystem.Contracts.Translation.Translations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Translation,
  cbsSystem.Locales.Locale,
  cbsSystem.Support.Types,
{SPRING}
  Spring.Collections;

type
  ITranslations = interface(IUnknown)
    ['{76FB3B9C-D2BD-49B6-BFEA-217256E6E22E}']
    function Translation(const ALocale: TLocale; const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string): string;
  end;

  ITranslationList = IDictionary<TLocale, ITranslation>;

  function CreateTranslationList: ITranslationList;

implementation

function CreateTranslationList: ITranslationList;
begin
  Result := TCollections.CreateDictionary<TLocale, ITranslation>;
end;

end.

