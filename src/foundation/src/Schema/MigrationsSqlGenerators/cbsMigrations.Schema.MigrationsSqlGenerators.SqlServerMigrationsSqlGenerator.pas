unit cbsMigrations.Schema.MigrationsSqlGenerators.SqlServerMigrationsSqlGenerator;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
  cbsMigrations.Contracts.Migrations.Operations.AlterColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.EnsureSchemaOperation,
  cbsMigrations.Contracts.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Contracts.Schema.MigrationsSqlGenerators.SqlServerMigrationsSqlGenerator,
  cbsMigrations.Schema.MigrationsSqlGenerators.MigrationsSqlGenerator;

type
  TSqlServerMigrationsSqlGenerator = class(TMigrationsSqlGenerator, ISqlServerMigrationsSqlGenerator)
  protected
    procedure Generate(const AOperation: IAlterColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IEnsureSchemaOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IRenameColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
  end;

implementation

{ TSqlServerMigrationsSqlGenerator }

procedure TSqlServerMigrationsSqlGenerator.Generate(const AOperation: IAlterColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('ALTER COLUMN')
   .Append(' ');
  ColumnDefinition(AOperation.Schema, AOperation.Table, AOperation.Name, AOperation, ABuilder);
  EndStatement(ABuilder);
end;

procedure TSqlServerMigrationsSqlGenerator.Generate(const AOperation: IEnsureSchemaOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('IF SCHEMA_ID(''')
   .Append(AOperation.Name)
   .Append(''') IS NULL EXEC(''')
   .Append('CREATE SCHEMA')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .Append(StatementTerminator)
   .Append(''')')
  .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TSqlServerMigrationsSqlGenerator.Generate(const AOperation: IRenameColumnOperation;
  const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('EXEC')
   .Append(' ')
   .Append('sp_rename')
   .Append(' ')
   .Append('''')
   .Append(AOperation.QualifiedTableName)
   .Append('.')
   .Append(AOperation.Name)
   .Append('''')
   .Append(',')
   .Append(' ')
   .Append('''')
   .Append(AOperation.NewName)
   .Append('''')
   .Append(',')
   .Append(' ')
   .Append('''COLUMN''')
  .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

end.
