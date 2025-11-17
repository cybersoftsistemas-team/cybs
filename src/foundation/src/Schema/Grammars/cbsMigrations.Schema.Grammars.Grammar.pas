unit cbsMigrations.Schema.Grammars.Grammar;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommand,
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
  cbsMigrations.Contracts.Schema.Grammars.Grammar,
  cbsMigrations.Contracts.Schema.MigrationsSqlGenerators.MigrationsSqlGenerator,
  cbsMigrations.Schema.Types,
  cbsMigrations.Support.Migration;

type
  TGrammar = class abstract(TInterfacedObject, IGrammar)
  private
    procedure CompileMigrationInserts(LBuilder: IMigrationCommandListBuilder; const AMigrationTypes: TArray<TClass>; const ADriverID: DriverID; const ATable: string; const ABatch: Integer);
  protected
    function CreateBuilder: IMigrationCommandListBuilder;
    function CreateSqlGenerator: IMigrationsSqlGenerator; virtual; abstract;
    function TableName(const ASchema, ATable: string): string;
    procedure RunUp(const ADriverID: DriverID; const AMigrationType: MigrationType; const ABuilder: IMigrationCommandListBuilder);
  public
    function CompileCreateRepository(const ADriverID: DriverID; const ATable: string): IMigrationCommands; virtual;
    function CompileGetRan(const ASchema, ATable: string): IMigrationCommand; virtual;
    function CompileGetLastBatchNumber(const ASchema, ATable: string): IMigrationCommand; virtual;
    function CompileRunPending(const ADriverID: DriverID; const AMigrationTypes: TArray<TClass>; const ABatch: Integer; const ATable: string): IMigrationCommands; virtual;
    function CompileTableExists(const ASchema, ATable: string): IMigrationCommand; virtual; abstract;
  end;

  GrammarType = class of TGrammar;

implementation

uses
{IDE}
  System.StrUtils,
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.Migration,
  cbsMigrations.Migrations.MigrationCommandListBuilder,
  _2025_05_30_00000001_create_migrations_history_table;

{ TGrammar }

function TGrammar.CompileCreateRepository(const ADriverID: DriverID; const ATable: string): IMigrationCommands;

  function CreateMigrationsHistory: IMigration;
  begin
    Result := CreateMigrationsHistoryTable.Create(ADriverID, ATable);
  end;

begin
  Result := CreateSqlGenerator.Generate(CreateMigrationsHistory.UpOperations);
end;

function TGrammar.CompileGetLastBatchNumber(const ASchema, ATable: string): IMigrationCommand;
begin
  Result :=
   CreateBuilder
    .Append('SELECT MAX(Batch) AS Batch ')
    .Append('FROM ')
    .Append(TableName(ASchema, ATable))
   .EndCommand
  .CommandList.First;
end;

function TGrammar.CompileGetRan(const ASchema, ATable: string): IMigrationCommand;
begin
  Result :=
   CreateBuilder
    .Append('SELECT Migration, ')
    .Append('Batch ')
    .Append('FROM ')
    .Append(TableName(ASchema, ATable))
    .Append(' ')
    .Append('ORDER BY ')
    .Append('Batch, ')
    .Append('Migration')
   .EndCommand
  .CommandList.First;
end;

function TGrammar.CompileRunPending(const ADriverID: DriverID; const AMigrationTypes: TArray<TClass>; const ABatch: Integer;
  const ATable: string): IMigrationCommands;
var
  LBuilder: IMigrationCommandListBuilder;
  LCommandList: ICommandList;
  LType: TClass;
begin
  LBuilder := CreateBuilder;
  for LType in AMigrationTypes do
  begin
    RunUp(ADriverID, MigrationType(LType), LBuilder);
  end;
  CompileMigrationInserts(LBuilder, AMigrationTypes, ADriverID, ATable, ABatch);
  LCommandList := CreateCommandList;
  LCommandList.AddRange(LBuilder.CommandList);
  Result := LCommandList;
end;

function TGrammar.CreateBuilder: IMigrationCommandListBuilder;
begin
  Result := TMigrationCommandListBuilder.Create;
end;

function TGrammar.TableName(const ASchema, ATable: string): string;
begin
  Result := IfThen(not ASchema.Trim.IsEmpty, Concat(ASchema, '.', ATable), ATable);
end;

procedure TGrammar.CompileMigrationInserts(LBuilder: IMigrationCommandListBuilder; const AMigrationTypes: TArray<TClass>; const ADriverID: DriverID; const ATable: string; const ABatch: Integer);
var
  LCreatedAtDefaultValue: string;
  LLast: TClass;
  LType: TClass;
begin
  LCreatedAtDefaultValue := '';
  if ADriverID = DriverID.MSSQL then
  begin
    LCreatedAtDefaultValue := 'GETDATE()';
  end;
  LBuilder
   .AppendLine
   .Append('INSERT INTO ')
   .Append(ATable)
   .Append(' ')
   .Append('VALUES')
   .Append(' ');
  LLast := AMigrationTypes[High(AMigrationTypes)];
  for LType in AMigrationTypes do
  begin
    LBuilder
     .Append('(''')
     .Append(LType.UnitName)
     .Append(''', ')
     .Append(ABatch.ToString)
     .Append(', ')
     .Append(LCreatedAtDefaultValue)
     .Append(')');
    if not (LLast = LType) then
    begin
      LBuilder
       .Append(',')
       .AppendLine;
    end;
  end;
  LBuilder.EndCommand;
end;

procedure TGrammar.RunUp(const ADriverID: DriverID; const AMigrationType: MigrationType;
  const ABuilder: IMigrationCommandListBuilder);

  function CreateMigration: IMigration;
  begin
    Result := AMigrationType.Create(ADriverID);
  end;

begin
  ABuilder.AppendCommands(CreateSqlGenerator.Generate(CreateMigration.UpOperations));
end;

end.
