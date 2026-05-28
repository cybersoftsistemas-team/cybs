unit cbsSystem.Support.Translations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Translation.Translations;

  function Translations: ITranslations;

implementation

uses
{PROJECT}
  cbsSystem.Translation.Translations,
  cbsSystem.Support.Container;

function Translations: ITranslations;
begin
  Result := App.Make<ITranslations>;
end;

end.
