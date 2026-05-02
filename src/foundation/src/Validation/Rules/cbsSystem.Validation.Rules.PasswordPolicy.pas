unit cbsSystem.Validation.Rules.PasswordPolicy;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Validation.Rules.PasswordPolicy,
  cbsSystem.Validation;

type
  PasswordPolicy = class(TValidation, IPasswordPolicy)
  private
    FLetters: Boolean;
    FMax: Integer;
    FMin: Integer;
    FMixedCase: Boolean;
    FNumbers: Boolean;
    FSymbols: Boolean;
  public
    function Min(const ASize: Integer = 8): IPasswordPolicy;
    function Letters: IPasswordPolicy;
    function Max(const ASize: Integer): IPasswordPolicy;
    function MixedCase: IPasswordPolicy;
    function Numbers: IPasswordPolicy;
    function Passes(const Attribute, AValue: string): Boolean;
    function Symbols: IPasswordPolicy;
  end;

implementation

uses
{IDE}
  System.RegularExpressions,
  System.SysUtils,
{PROJECT}
  System.Math;

{ PasswordPolicy }

function PasswordPolicy.Letters: IPasswordPolicy;
begin
  FLetters := True;
  Result := Self;
end;

function PasswordPolicy.Max(const ASize: Integer): IPasswordPolicy;
begin
  FMax := ASize;
  Result := Self;
end;

function PasswordPolicy.Min(const ASize: Integer): IPasswordPolicy;
begin
  FMin := System.Math.Max(ASize, 1);
  Result := Self;
end;

function PasswordPolicy.MixedCase: IPasswordPolicy;
begin
  FMixedCase := True;
  Result := Self;
end;

function PasswordPolicy.Numbers: IPasswordPolicy;
begin
  FNumbers := True;
  Result := Self;
end;

function PasswordPolicy.Passes(const Attribute, AValue: string): Boolean;
begin
  if FMin > AValue.Length then
  begin
    Fail('password', 'min.string',
      [['attribute', Attribute], ['min', FMin.ToString]]);
  end;
  if (0 < FMax) and (FMax < AValue.Length) then
  begin
    Fail('password', 'max.string',
      [['attribute', Attribute], ['max', FMax.ToString]]);
  end;
  if FMixedCase and not (
    TRegEx.IsMatch(AValue, '[a-z]') and
    TRegEx.IsMatch(AValue, '[A-Z]')
  ) then
  begin
    Fail('password', 'password.mixed', [['attribute', Attribute]]);
  end;
  if FLetters and not TRegEx.IsMatch(AValue, '[A-Za-z]') then
  begin
    Fail('password', 'password.letters', [['attribute', Attribute]]);
  end;
  if FNumbers and not TRegEx.IsMatch(AValue, '\d') then
  begin
    Fail('password', 'password.numbers', [['attribute', Attribute]]);
  end;
  if FSymbols and not TRegEx.IsMatch(AValue,
    '[!@#$%^&*()_\-+=\[\]{};:,.<>/?\\|]') then
  begin
    Fail('password', 'password.symbols', [['attribute', Attribute]]);
  end;
  Result := Message.IsEmpty;
end;

function PasswordPolicy.Symbols: IPasswordPolicy;
begin
  FSymbols := True;
  Result := Self;
end;

end.
