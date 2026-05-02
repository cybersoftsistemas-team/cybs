unit cbsSystem.Translation.Translation;

interface

uses
{IDE}
  System.Rtti,
{PROJECT}
  cbsSystem.Contracts.Translation,
  cbsSystem.PathTree;

type
  TTranslation = class abstract(TPathTree, ITranslation)
  protected
    procedure SetTranslations; virtual; abstract;
  public
    constructor Create;
  end;

implementation

{ TTranslation }

constructor TTranslation.Create;
begin
  inherited Create;
  SetTranslations;
end;

end.
