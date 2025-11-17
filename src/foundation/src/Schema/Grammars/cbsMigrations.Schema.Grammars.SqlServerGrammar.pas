unit cbsMigrations.Schema.Grammars.SqlServerGrammar;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommand,
  cbsMigrations.Contracts.Schema.Grammars.SqlServerGrammar,
  cbsMigrations.Contracts.Schema.MigrationsSqlGenerators.MigrationsSqlGenerator,
  cbsMigrations.Schema.Grammars.Grammar;

type
  TSqlServerGrammar = class(TGrammar, ISqlServerGrammar)
  protected
    function CreateSqlGenerator: IMigrationsSqlGenerator; override;
  public
    function CompileTableExists(const ASchema, ATable: string): IMigrationCommand; override;
  end;

implementation

uses
{PROJECT}
  cbsMigrations.Schema.MigrationsSqlGenerators.SqlServerMigrationsSqlGenerator;

{ TSqlServerGrammar }

function TSqlServerGrammar.CreateSqlGenerator: IMigrationsSqlGenerator;
begin
  Result := TSqlServerMigrationsSqlGenerator.Create;
end;

function TSqlServerGrammar.CompileTableExists(const ASchema, ATable: string): IMigrationCommand;
begin
  Result :=
   CreateBuilder
    .Append('SELECT CAST((CASE WHEN OBJECT_ID(N''')
    .Append(TableName(ASchema, ATable))
    .Append(''', N''U'') IS NULL THEN 0 ELSE 1 END) AS BIT) AS [EXISTS]')
   .EndCommand
  .CommandList.First;
end;

end.
