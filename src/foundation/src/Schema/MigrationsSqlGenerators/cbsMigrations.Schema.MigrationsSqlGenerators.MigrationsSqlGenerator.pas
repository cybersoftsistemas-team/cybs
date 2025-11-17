unit cbsMigrations.Schema.MigrationsSqlGenerators.MigrationsSqlGenerator;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.AddBooleanColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddCheckConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddDateColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddDateTimeColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddFloatColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddGuidColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddIntColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddPrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddStringColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.AddUniqueConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.AlterColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.ColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.CreateIndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.CreateTableOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropCheckConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropIndexOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropPrimaryKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropSchemaOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropTableOperation,
  cbsMigrations.Contracts.Migrations.Operations.DropUniqueConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.ForeignKeyOperation,
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation,
  cbsMigrations.Contracts.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.SqlOperation,
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
  cbsMigrations.Contracts.Schema.MigrationsSqlGenerators.MigrationsSqlGenerator,
  cbsMigrations.Migrations.MigrationsSqlGeneratorBase;

type
  TMigrationsSqlGenerator = class(TMigrationsSqlGeneratorBase, IMigrationsSqlGenerator)
  private
    procedure AddColumnOperation(const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure CheckConstraint(const AOperation: IAddCheckConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure CreateTableColumns(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder); overload;
    procedure CreateTableCheckConstraints(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure CreateTableConstraints(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure CreateTableForeignKeys(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure CreateTablePrimaryKeyConstraint(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure CreateTableUniqueConstraints(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure ForeignKeyAction(const AReferentialAction: ReferentialAction; const ABuilder: IMigrationCommandListBuilder);
    procedure ForeignKeyConstraint(const AOperation: IAddForeignKeyOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure GenerateIndexColumnList(const AOperation: ICreateIndexOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure IndexOptions(const AOperation: IMigrationOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure PrimaryKeyConstraint(const AOperation: IAddPrimaryKeyOperation; const ABuilder: IMigrationCommandListBuilder);
    procedure UniqueConstraint(const AOperation: IAddUniqueConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
  protected
    procedure ColumnDefinition(const ASchema, ATable, AName: string; const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual;
    procedure ColumnDefinition(const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual;
    procedure DefaultValue(const ADefaultValueSql: string; const ABuilder: IMigrationCommandListBuilder);
    procedure Generate(const AOperation: IAddBooleanColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddCheckConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddDateColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddDateTimeColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddFloatColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddForeignKeyOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddGuidColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddIntColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddPrimaryKeyOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddStringColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IAddUniqueConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: ICreateIndexOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropCheckConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropForeignKeyOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropIndexOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropPrimaryKeyOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropSchemaOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropTableOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IDropUniqueConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: IRenameColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure Generate(const AOperation: ISqlOperation; const ABuilder: IMigrationCommandListBuilder); overload; override;
    procedure IndexTraits(const AOperation: IMigrationOperation; const ABuilder: IMigrationCommandListBuilder); virtual;
  end;

implementation

uses
{IDE}
  System.StrUtils,
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.ConstraintOperation,
  cbsMigrations.Contracts.Migrations.Operations.StringColumnOperation,
  cbsMigrations.Migrations.Operations.AddCheckConstraintOperation,
  cbsMigrations.Migrations.Operations.AddForeignKeyOperation,
  cbsMigrations.Migrations.Operations.AddUniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.AlterColumnOperation,
  cbsMigrations.Migrations.Operations.ColumnOperation,
  cbsMigrations.Migrations.Operations.CreateIndexOperation,
  cbsMigrations.Migrations.Operations.StringColumnOperation;

{ TMigrationsSqlGenerator }

procedure TMigrationsSqlGenerator.AddColumnOperation(const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('ADD')
   .Append(' ');
  ColumnDefinition(AOperation, ABuilder);
  ABuilder
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.DefaultValue(const ADefaultValueSql: string; const ABuilder: IMigrationCommandListBuilder);
begin
  if not ADefaultValueSql.Trim.IsEmpty then
  begin
    ABuilder
     .Append(' ')
     .Append('DEFAULT (')
     .Append(ADefaultValueSql)
     .Append(')');
  end;
end;

procedure TMigrationsSqlGenerator.ColumnDefinition(const ASchema, ATable, AName: string; const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder);
var
  LCollation: string;
begin
  ABuilder
   .Append(DelimitIdentifier(AName))
   .Append(' ')
   .Append(AOperation.ColumnType);
  LCollation :='';
  if Supports(AOperation, IAlterColumnOperation) then
  begin
    LCollation := TAlterColumnOperation(AOperation).Collation;
  end
  else if Supports(AOperation, IStringColumnOperation) then
  begin
    LCollation := TStringColumnOperation(AOperation).Collation;
  end;
  if not LCollation.Trim.IsEmpty then
  begin
    ABuilder
     .Append(' ')
     .Append('COLLATE')
     .Append(' ')
     .Append(LCollation);
  end;
  ABuilder.Append(IfThen(AOperation.Nullable, ' NULL', ' NOT NULL'));
  DefaultValue(AOperation.DefaultValueSql, ABuilder);
end;

procedure TMigrationsSqlGenerator.ColumnDefinition(const AOperation: IColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ColumnDefinition(AOperation.Schema, AOperation.Table, AOperation.Name, AOperation, ABuilder);
end;

procedure TMigrationsSqlGenerator.CreateTableColumns(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
var
  LLast: IColumnOperation;
  LOperation: IColumnOperation;
begin
  LLast := AOperation.Columns.Last;
  for LOperation in AOperation.Columns do
  begin
    ColumnDefinition(LOperation, ABuilder);
    if not(LLast = LOperation) then
    begin
      ABuilder.AppendLine(',')
       .Append(' ');
    end;
  end;
end;

procedure TMigrationsSqlGenerator.CheckConstraint(const AOperation: IAddCheckConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append(' ')
   .Append('CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .Append(' ')
   .Append('CHECK')
   .Append(' ')
   .Append('(')
   .Append(AOperation.Sql)
   .Append(')');
end;

procedure TMigrationsSqlGenerator.CreateTableCheckConstraints(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
var
  LConstraint: IConstraintOperation;
begin
  for LConstraint in AOperation.Constraints.Where(
    function(const AConstraint: IConstraintOperation): Boolean
    begin
      Result := Supports(AConstraint, IAddCheckConstraintOperation);
    end
  ) do
  begin
    ABuilder.AppendLine(',');
    CheckConstraint(TAddCheckConstraintOperation(LConstraint), ABuilder);
  end;
end;

procedure TMigrationsSqlGenerator.CreateTableConstraints(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  CreateTablePrimaryKeyConstraint(AOperation, ABuilder);
  CreateTableUniqueConstraints(AOperation, ABuilder);
  CreateTableCheckConstraints(AOperation, ABuilder);
  CreateTableForeignKeys(AOperation, ABuilder);
end;

procedure TMigrationsSqlGenerator.CreateTableForeignKeys(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
var
  LConstraint: IConstraintOperation;
begin
  for LConstraint in AOperation.Constraints.Where(
    function(const AConstraint: IConstraintOperation): Boolean
    begin
      Result := Supports(AConstraint, IAddForeignKeyOperation);
    end
  ) do
  begin
    ABuilder.AppendLine(',');
    ForeignKeyConstraint(TAddForeignKeyOperation(LConstraint), ABuilder);
  end;
end;

procedure TMigrationsSqlGenerator.CreateTablePrimaryKeyConstraint(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
var
  LPrimaryKey: IAddPrimaryKeyOperation;
begin
  LPrimaryKey := AOperation.Constraints.FirstOrDefault(
    function(const AConstraint: IConstraintOperation): Boolean
    begin
      Result := Supports(AConstraint, IAddPrimaryKeyOperation);
    end)
    as IAddPrimaryKeyOperation;
  if Assigned(LPrimaryKey) then
  begin
    ABuilder.AppendLine(',');
    PrimaryKeyConstraint(LPrimaryKey, ABuilder);
  end;
end;

procedure TMigrationsSqlGenerator.CreateTableUniqueConstraints(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
var
  LConstraint: IConstraintOperation;
begin
  for LConstraint in AOperation.Constraints.Where(
    function(const AConstraint: IConstraintOperation): Boolean
    begin
      Result := Supports(AConstraint, IAddUniqueConstraintOperation);
    end
  ) do
  begin
    ABuilder.AppendLine(',');
    UniqueConstraint(TAddUniqueConstraintOperation(LConstraint), ABuilder);
  end;
end;

procedure TMigrationsSqlGenerator.ForeignKeyAction(const AReferentialAction: ReferentialAction;
  const ABuilder: IMigrationCommandListBuilder);
begin
  case AReferentialAction of
    ReferentialAction.Restrict: ABuilder.Append('RESTRICT');
    ReferentialAction.Cascade: ABuilder.Append('CASCADE');
    ReferentialAction.SetNull: ABuilder.Append('SET NULL');
    ReferentialAction.SetDefault: ABuilder.Append('SET DEFAULT');
  end;
end;

procedure TMigrationsSqlGenerator.ForeignKeyConstraint(const AOperation: IAddForeignKeyOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append(' ')
   .Append('CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .Append(' ')
   .Append('FOREIGN KEY')
   .Append(' ')
   .Append('(')
   .Append(ColumnList(AOperation.Columns.ToArray))
   .Append(') REFERENCES')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.PrincipalTable, AOperation.PrincipalSchema))
   .Append(' ')
   .Append('(')
   .Append(ColumnList(AOperation.PrincipalColumns.ToArray))
   .Append(')');
   if not(AOperation.OnDelete = ReferentialAction.NoAction) then
   begin
     ABuilder
      .Append(' ')
      .Append('ON DELETE')
      .Append(' ');
     ForeignKeyAction(AOperation.OnDelete, ABuilder);
   end;
   if not(AOperation.OnUpdate = ReferentialAction.NoAction) then
   begin
     ABuilder
      .Append(' ')
      .Append('ON UPDATE')
      .Append(' ');
     ForeignKeyAction(AOperation.OnUpdate, ABuilder);
   end;
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddBooleanColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  AddColumnOperation(TColumnOperation(AOperation), ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddCheckConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, Aoperation.Schema))
   .Append(' ')
   .Append('ADD')
   .Append(' ');
  CheckConstraint(AOperation, ABuilder);
  ABuilder.AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddDateColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  AddColumnOperation(TColumnOperation(AOperation), ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddDateTimeColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  AddColumnOperation(TColumnOperation(AOperation), ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddFloatColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  AddColumnOperation(TColumnOperation(AOperation), ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddForeignKeyOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('ADD')
   .Append(' ');
  ForeignKeyConstraint(AOperation, ABuilder);
  ABuilder.AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddGuidColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  AddColumnOperation(TColumnOperation(AOperation), ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddIntColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  AddColumnOperation(TColumnOperation(AOperation), ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddPrimaryKeyOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('ADD')
   .Append(' ');
  PrimaryKeyConstraint(AOperation, ABuilder);
  ABuilder.AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddStringColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  AddColumnOperation(TColumnOperation(AOperation), ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IAddUniqueConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('ADD')
   .Append(' ');
  UniqueConstraint(AOperation, ABuilder);
  ABuilder.AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: ICreateIndexOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('CREATE')
   .Append(' ');
  if AOperation.Unique then
  begin
    ABuilder
     .Append('UNIQUE')
     .Append(' ');
  end;
  IndexTraits(AOperation, ABuilder);
  ABuilder
   .Append('INDEX')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .Append(' ')
   .Append('ON')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('(');
  GenerateIndexColumnList(AOperation, ABuilder);
  ABuilder
   .Append(')');
  IndexOptions(AOperation, ABuilder);
  ABuilder.AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('CREATE TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .AppendLine('(');
  CreateTableColumns(AOperation, ABuilder);
  CreateTableConstraints(AOperation, ABuilder);
  ABuilder
   .AppendLine
   .Append(')')
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.PrimaryKeyConstraint(const AOperation: IAddPrimaryKeyOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append(' ')
   .Append('CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .Append(' ')
   .Append('PRIMARY KEY')
   .Append(' ')
   .Append('(')
   .Append(ColumnList(AOperation.Columns.ToArray))
   .Append(')');
end;

procedure TMigrationsSqlGenerator.UniqueConstraint(const AOperation: IAddUniqueConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append(' ')
   .Append('CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .Append(' ')
   .Append('UNIQUE ')
   .Append('(')
   .Append(ColumnList(AOperation.Columns.ToArray))
   .Append(')');
end;

procedure TMigrationsSqlGenerator.GenerateIndexColumnList(const AOperation: ICreateIndexOperation; const ABuilder: IMigrationCommandListBuilder);
var
  I: Integer;
  LColumns: TArray<string>;
begin
  LColumns := AOperation.Columns.ToArray;
  for I := Low(LColumns) to High(LColumns) do
  begin
    if I > 0 then
    begin
      ABuilder
       .Append(',')
       .Append(' ');
    end;
    ABuilder.Append(DelimitIdentifier(LColumns[I]));
    if (Length(AOperation.Descending) > 0) and
      (Length(AOperation.Descending) = Length(LColumns)) and
      (AOperation.Descending[I]) then
    begin
      ABuilder
       .Append(' ')
       .Append('DESC');
    end;
  end;
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IDropCheckConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('DROP CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IDropColumnOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('DROP COLUMN')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IDropForeignKeyOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('DROP CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IDropIndexOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('DROP CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IDropPrimaryKeyOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('DROP CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IDropSchemaOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('DROP SCHEMA')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IDropTableOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('DROP TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IDropUniqueConstraintOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('DROP CONSTRAINT')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.IndexOptions(const AOperation: IMigrationOperation; const ABuilder: IMigrationCommandListBuilder);
var
  LCreateIndexOperation: ICreateIndexOperation;
begin
  if Supports(AOperation, ICreateIndexOperation) then
  begin
    LCreateIndexOperation := TCreateIndexOperation(AOperation);
    if not TCreateIndexOperation(AOperation).Filter.Trim.IsEmpty then
    begin
      ABuilder
       .Append(' ')
       .Append('WHERE')
       .Append(' ')
       .Append(LCreateIndexOperation.Filter);
    end;
  end;
end;

procedure TMigrationsSqlGenerator.IndexTraits(const AOperation: IMigrationOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  // This method can be overwritten by inherited classes.
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: IRenameColumnOperation;
  const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder
   .Append('ALTER TABLE')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Table, AOperation.Schema))
   .Append(' ')
   .Append('RENAME')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.Name))
   .Append(' ')
   .Append('TO')
   .Append(' ')
   .Append(DelimitIdentifier(AOperation.NewName));
  ABuilder.AppendLine(StatementTerminator);
  EndStatement(ABuilder);
end;

procedure TMigrationsSqlGenerator.Generate(const AOperation: ISqlOperation; const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder.AppendLine(NormalizeTheSQLScript(AOperation.Sql));
  EndStatement(ABuilder);
end;

end.
