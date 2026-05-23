unit cbsMigrations.Schema.MigrationsSqlGenerators.SqlServerMigrationsSqlGenerator;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
  cbsMigrations.Contracts.Migrations.Operations.AddDefaultConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.AlterColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.CreateTableOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropDefaultConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.EnsureSchemaOperation,
  cbsMigrations.Contracts.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Contracts.Schema.MigrationsSqlGenerators.SqlServerMigrationsSqlGenerator,
  cbsMigrations.Schema.MigrationsSqlGenerators.MigrationsSqlGenerator;

type
  TSqlServerMigrationsSqlGenerator = class(TMigrationsSqlGenerator, ISqlServerMigrationsSqlGenerator)
  protected
    procedure ColumnIdentityDefinition(const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder); override;
    procedure CreateDefaultConstraint(const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder); override;
    procedure CreateDefaultConstraints(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder); override;
    procedure DefaultValue(const ADefaultValueSql: string; const ABuilder: IMigrationCommandListBuilder); override;
    procedure Generate(const AOperation: IAddDefaultConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAlterColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropDefaultConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IEnsureSchemaOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IRenameColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.IntColumnOperation,
  cbsMigrations.Migrations.Operations.AddDefaultConstraintOperation;

{ TSqlServerMigrationsSqlGenerator }

procedure TSqlServerMigrationsSqlGenerator.ColumnIdentityDefinition(const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder);
var
  LIntColumnOperation: IIntColumnOperation;
begin
  if Supports(AOperation, IIntColumnOperation, LIntColumnOperation) and
    LIntColumnOperation.IsIncrement then
  begin
    ABuilder
     .Append(' ')
     .Append('IDENTITY(')
     .Append(LIntColumnOperation.Seed.ToString)
     .Append(',')
     .Append(LIntColumnOperation.Increment.ToString)
     .Append(')');
  end;
end;

procedure TSqlServerMigrationsSqlGenerator.CreateDefaultConstraint(const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  if AOperation.DefaultValueSql.Trim.IsEmpty then
    Exit;
  var LOperation: IAddDefaultConstraintOperation :=
    TAddDefaultConstraintOperation.Create('', AOperation.Name, AOperation.DefaultValueSql)
     .HasTable(AOperation.Table)
     .HasSchema(AOperation.Schema);
  LOperation.Prepare;
  Generate(LOperation, ABuilder);
end;

procedure TSqlServerMigrationsSqlGenerator.CreateDefaultConstraints(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  for var LColumn in AOperation.Columns do
  begin
    CreateDefaultConstraint(LColumn, ABuilder);
  end;
end;

procedure TSqlServerMigrationsSqlGenerator.DefaultValue(const ADefaultValueSql: string; const ABuilder: IMigrationCommandListBuilder);
begin
  // To prevent SQL Server from generating inline DEFAULT results.
end;

procedure TSqlServerMigrationsSqlGenerator.Generate(const AOperation: IAddDefaultConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .AppendLine('DECLARE @DefaultConstraintName NVARCHAR(255);')
   .AppendLine
   .Append('SELECT')
   .AppendLine
   .Append('@DefaultConstraintName = dc.name')
   .AppendLine
   .Append('FROM sys.default_constraints dc')
   .AppendLine
   .Append('INNER JOIN sys.columns c')
   .AppendLine
   .Append('ON c.default_object_id = dc.object_id')
   .AppendLine
   .Append('INNER JOIN sys.tables t')
   .AppendLine
   .Append('ON t.object_id = c.object_id')
   .AppendLine
   .Append('INNER JOIN sys.schemas s')
   .AppendLine
   .Append('ON s.schema_id = t.schema_id')
   .AppendLine
   .Append('WHERE s.name = ')
   .Append(QuotedStr(AOperation.Schema))
   .AppendLine
   .Append('AND t.name = ')
   .Append(QuotedStr(AOperation.Table))
   .AppendLine
   .Append('AND c.name = ')
   .Append(QuotedStr(AOperation.ColumnName))
   .AppendLine(StatementTerminator)
   .AppendLine
   .AppendLine('IF @DefaultConstraintName IS NOT NULL')
   .AppendLine('BEGIN')
   .Append('    RAISERROR(')
   .Append(
     QuotedStr('A default constraint already exists for column "%s" in table "%s.%s". Existing constraint: %s')
   )
   .Append(', ')
   .Append('16')
   .Append(', ')
   .Append('1')
   .Append(', ')
   .Append(QuotedStr(AOperation.ColumnName))
   .Append(', ')
   .Append(QuotedStr(AOperation.Schema))
   .Append(', ')
   .Append(QuotedStr(AOperation.Table))
   .Append(', ')
   .Append('@DefaultConstraintName')
   .Append(')')
   .AppendLine(StatementTerminator)
   .AppendLine('END')
   .AppendLine
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('ADD')
   .Append(' ')
   .Append('CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .Append(' ')
   .Append('DEFAULT')
   .Append(' ')
   .Append('(')
   .Append(AOperation.Value)
   .Append(')')
   .Append(' ')
   .Append('FOR')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.ColumnName))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

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

procedure TSqlServerMigrationsSqlGenerator.Generate(const AOperation: IDropDefaultConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .AppendLine('DECLARE @DefaultConstraintName NVARCHAR(255);')
   .AppendLine('DECLARE @Sql NVARCHAR(MAX);')
   .AppendLine
   .Append('SELECT')
   .AppendLine
   .Append('@DefaultConstraintName = dc.name')
   .AppendLine
   .Append('FROM sys.default_constraints dc')
   .AppendLine
   .Append('INNER JOIN sys.columns c')
   .AppendLine
   .Append('ON c.default_object_id = dc.object_id')
   .AppendLine
   .Append('INNER JOIN sys.tables t')
   .AppendLine
   .Append('ON t.object_id = c.object_id')
   .AppendLine
   .Append('INNER JOIN sys.schemas s')
   .AppendLine
   .Append('ON s.schema_id = t.schema_id')
   .AppendLine
   .Append('WHERE s.name = ')
   .Append(QuotedStr(AOperation.Schema))
   .AppendLine
   .Append('AND t.name = ')
   .Append(QuotedStr(AOperation.Table))
   .AppendLine
   .Append('AND c.name = ')
   .Append(QuotedStr(AOperation.ColumnName))
   .AppendLine(StatementTerminator)
   .AppendLine
   .AppendLine('IF @DefaultConstraintName IS NOT NULL')
   .AppendLine('BEGIN')
   .Append('    SET @Sql = ')
   .Append(
     QuotedStr(
       'ALTER TABLE ' +
       DelimitIdentifier(AOperation.Table, AOperation.Schema) +
       ' DROP CONSTRAINT '
     )
   )
   .Append(' + QUOTENAME(@DefaultConstraintName)')
   .AppendLine(StatementTerminator)
   .AppendLine
   .AppendLine('    EXEC(@Sql);')
   .AppendLine('END')
   .AppendLine(StatementTerminator);
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

procedure TSqlServerMigrationsSqlGenerator.Generate(const AOperation: IRenameColumnOperation; const ABuilder: IMigrationCommandListBuilder);
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
