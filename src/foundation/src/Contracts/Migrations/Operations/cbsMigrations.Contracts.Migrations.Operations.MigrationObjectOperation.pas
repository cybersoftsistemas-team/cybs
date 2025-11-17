unit cbsMigrations.Contracts.Migrations.Operations.MigrationObjectOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation;

type
  IMigrationObjectOperation = interface(IMigrationOperation)
    ['{563A01D5-2F98-4D19-9EE8-8869DFDD6CA7}']
    function GetSchema: string;
    function GetTable: string;
    function QualifiedTableName(const ASeparator: Char = #0): string;
    property Schema: string read GetSchema;
    property Table: string read GetTable;
  end;

implementation

end.
