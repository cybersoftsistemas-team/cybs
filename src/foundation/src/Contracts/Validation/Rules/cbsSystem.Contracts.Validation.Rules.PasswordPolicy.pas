unit cbsSystem.Contracts.Validation.Rules.PasswordPolicy;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Validation.Rule;

type
  IPasswordPolicy = interface(IRule)
    ['{03EBDF8E-F1B8-469B-8DFB-37D6D5281C92}']
    function Min(const ASize: Integer = 8): IPasswordPolicy;
    function Letters: IPasswordPolicy;
    function Max(const ASize: Integer): IPasswordPolicy;
    function MixedCase: IPasswordPolicy;
    function Numbers: IPasswordPolicy;
    function Passes(const Attribute, AValue: string): Boolean;
    function Symbols: IPasswordPolicy;
  end;

implementation

end.
