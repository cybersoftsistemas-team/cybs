unit cbsMigrations.Contracts.Migrations.DatabaseMigrationRepository;

interface

type
  TMigrationName = string;

  IDatabaseMigrationRepository = interface(IUnknown)
    ['{B430F5E6-9D53-4A58-9B50-A260B51273D0}']
    function GetRan: TArray<TMigrationName>;
    function GetTable: string;
    procedure SetTable(const AValue: string);
    procedure CreateIfNotExists;
    procedure RunPending(const AMigrationTypes: TArray<TClass>);
    property Table: string read GetTable write SetTable;
  end;

implementation

end.
