unit cbsSystem.Support.Translations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Translation.Translations;

  function Translations: ITranslations;

  procedure CreateTranslations;
  procedure DestroyTranslations;

implementation

uses
{PROJECT}
  cbsSystem.Translation.Translations;

var
  InternalTranslations: ITranslations;

function Translations: ITranslations;
begin
  Result := InternalTranslations;
end;

procedure CreateTranslations;
begin
  if not Assigned(InternalTranslations) then
  begin
    InternalTranslations := TTranslations.Create;
  end;
end;

procedure DestroyTranslations;
begin
  InternalTranslations := nil;
end;

end.
