unit cbsSystem.Translation.Lang.pt_br;

interface

uses
{PROJECT}
  cbsSystem.Translation.Translation;

type
  TLangPtBr = class(TTranslation)
  protected
    procedure SetTranslations; override;
  end;

implementation

uses
{IDE}
  System.Rtti;

{ TLangPtBr }

procedure TLangPtBr.SetTranslations;
begin
  &Set('confirmed', 'A confirmação para o campo :attribute não coincide.');
  &Set('current_password', 'A senha atual está incorreta.');

  // min
  &Set('min.numeric', 'O campo :attribute deve conter um número superior ou igual a :min.');
  &Set('min.file'   , 'O campo :attribute deve conter um arquivo com no mínimo :min kilobytes.');
  &Set('min.string' , 'O campo :attribute deve conter no mínimo :min caracteres.');
  &Set('min.array'  , 'O campo :attribute deve conter no mínimo :min itens.');

  // max
  &Set('max.numeric', 'O campo :attribute não pode conter um valor superior a :max.');
  &Set('max.file'   , 'O campo :attribute não pode conter um arquivo com mais de :max kilobytes.');
  &Set('max.string' , 'O campo :attribute não pode conter mais de :max caracteres.');
  &Set('max.array'  , 'O campo :attribute deve conter no máximo :max itens.');

  // password
  &Set('password.letters', 'A :attribute deve conter pelo menos uma letra.');
  &Set('password.mixed'  , 'A :attribute deve conter pelo menos uma letra maiúscula e uma minúscula.');
  &Set('password.numbers', 'A :attribute deve conter pelo menos um número.');
  &Set('password.symbols', 'A :attribute deve conter pelo menos um símbolo.');

  // user
  &Set('user.notfound', 'O usuário não pôde ser encontrado.');
end;

end.
