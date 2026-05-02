unit cbsSystem.Translation.Translations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Translation.Translations,
  cbsSystem.Contracts.PathTree,
  cbsSystem.Locales.Locale,
  cbsSystem.Support.Types;

type
  TTranslations = class(TInterfacedObject, ITranslations)
  private
    FTranslationList: ITranslationList;
    procedure SetTranslation;
  public
    constructor Create;
    destructor Destroy; override;
    function Translation(const ALocale: TLocale; const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string): string;
  end;

implementation

uses
{IDE}
  System.Rtti,
  System.SysUtils,
{PROJECT}
  cbsSystem.Translation.ForReplacement,
  cbsSystem.Translation.Lang.pt_br;

{ TTranslations }

constructor TTranslations.Create;
begin
  inherited Create;
  FTranslationList := CreateTranslationList;
  SetTranslation;
end;

destructor TTranslations.Destroy;
begin
  FTranslationList.Clear;
  FTranslationList := nil;
  inherited;
end;

procedure TTranslations.SetTranslation;
begin
  FTranslationList[TLocale.pt_br] := TLangPtBr.Create;
end;

function TTranslations.Translation(const ALocale: TLocale; const APath: string; const AReplacements: TForReplacements; const ADefaultValue: string): string;
begin
  if not FTranslationList.ContainsKey(ALocale) then
    Exit(ADefaultValue);
  var LTranslation := FTranslationList[ALocale].Get(APath, TValue.From(ADefaultValue));
  if not LTranslation.IsType<string> then
    Exit(ADefaultValue);
  Result := TForReplacement.Resolve(LTranslation.AsType<string>, AReplacements);
end;

end.





