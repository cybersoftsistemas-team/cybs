unit cbsMigrations.Contracts.Migrations.Operations.SqlOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation;

type
  ISqlOperation = interface(IMigrationOperation)
    ['{F895A57C-B77A-4BEB-A054-BBC772BE1724}']
    function GetSql: string;
    function HasSql(const ASql: string): ISqlOperation;
    property Sql: string read GetSql;
  end;

implementation

end.
