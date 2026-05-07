unit cbsSystem.Translation.Translator;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Translation.Translator,
  cbsSystem.Locales.Locale,

  cbsSystem.Support.Types;

type
  TTranslator = class(TInterfacedObject, ITranslator)
  private
    FLocale: TLocale;
    function GetLocale: TLocale;
    procedure SetLocale(const AValue: TLocale);
  public
    constructor Create;
    function Translation(const APath: string; const ADefaultValue: string = ''): string; overload;
    function Translation(const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string = ''): string; overload;
    property Locale: TLocale read GetLocale write SetLocale default TLocale.en;
  end;

implementation

uses
{PROJECT}
  cbsSystem.Support.Translations;

{ TTranslator }

constructor TTranslator.Create;
begin
  inherited Create;
  FLocale := TLocale.en;
end;

function TTranslator.GetLocale: TLocale;
begin
  Result := FLocale;
end;

procedure TTranslator.SetLocale(const AValue: TLocale);
begin
  FLocale := AValue;
end;

function TTranslator.Translation(const APath, ADefaultValue: string): string;
begin
  Result := Translation(APath, [], ADefaultValue);
end;

function TTranslator.Translation(const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string): string;
begin
  Result := Translations.Translation(FLocale, APath, AReplacements, ADefaultValue);
end;

end.
