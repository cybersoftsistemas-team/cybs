unit cbsMigrations.Contracts.Schema.Builder;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Schema.Grammars.Grammar;

type
  IBuilder = interface(IUnknown)
    ['{06989661-C1A7-4118-B11E-D7A9DF0042F4}']
    function GetGrammar: IGrammar;
    function GetLastBatchNumber(const ATable: string): Integer;
    function GetRan(const ATable: string): TArray<string>;
    function HasTable(const ATable: string): Boolean;
    procedure CreateIfNotExists(const ATable: string);
    procedure RunPending(const AMigrationTypes: TArray<TClass>; const ATable: string);
    property Grammar: IGrammar read GetGrammar;
  end;

implementation

end.
