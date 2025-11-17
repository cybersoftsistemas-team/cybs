unit cbsMigrations.Contracts.Schema.Grammars;

interface

uses
{PROJECT}
  cbsMigrations.Schema.Grammars.Grammar,
  cbsMigrations.Schema.Types,
{SPRING}
  Spring.Collections;

type
  IGrammars = interface(IUnknown)
    ['{9E5E01DA-EADC-4F79-9450-88A45929FD6A}']
    function Add(const ADriverID: DriverID; const AGrammarType: GrammarType): IGrammars;
    function GetDriver(const ADriverID: DriverID): GrammarType;
    property Driver[const ADriverID: DriverID]: GrammarType read GetDriver; default;
  end;

  IGrammarList = IDictionary<DriverID, GrammarType>;

  function CreateGrammarList: IGrammarList;

implementation

function CreateGrammarList: IGrammarList;
begin
  Result := TCollections.CreateDictionary<DriverID, GrammarType>;
end;

end.
