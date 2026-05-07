unit cbsSystem.Contracts.Translation.Translator;

interface

uses
{PROJECT}
  cbsSystem.Locales.Locale,
  cbsSystem.Support.Types;

type
  ITranslator = interface(IUnknown)
    ['{4BCE1870-4C0D-4366-856D-81EF22015010}']
    function GetLocale: TLocale;
    function Translation(const APath: string; const ADefaultValue: string = ''): string; overload;
    function Translation(const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string = ''): string; overload;
    procedure SetLocale(const AValue: TLocale);
    property Locale: TLocale read GetLocale write SetLocale;
  end;

implementation

end.
