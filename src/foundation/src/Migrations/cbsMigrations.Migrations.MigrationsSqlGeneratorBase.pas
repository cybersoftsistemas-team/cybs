unit cbsMigrations.Migrations.MigrationsSqlGeneratorBase;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationsSqlGeneratorBase,
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
  cbsMigrations.Contracts.Migrations.Operations.EnsureSchemaOperation,
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation,
  cbsMigrations.Contracts.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Contracts.Migrations.Operations.SqlOperation,
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
{SPRING}
  Spring.Collections;

type
  TMigrationsSqlGeneratorBase = class abstract(TInterfacedObject, IMigrationsSqlGeneratorBase)
  private
    type
      TGenerateAction = reference to procedure(
        const AGenerator: TMigrationsSqlGeneratorBase;
        const AOperation: IMigrationOperation;
        const ABuilder: IMigrationCommandListBuilder
      );
      IGenerateActions = IDictionary<TGUID, TGenerateAction>;
  private
    FGenerateActions: IGenerateActions;
    function CreateGenerateActionList: IGenerateActions;
  protected
    const
      StatementTerminator: string = ';';
  protected
    function ColumnList(const AColumns: TArray<string>): string;
    function DelimitIdentifier(const AIdentifier: string): string; overload;
    function DelimitIdentifier(const AName, ASchema: string): string; overload;
    function EscapeIdentifier(const AIdentifier: string): string;
    function NormalizeTheSQLScript(const AScript: string): string;
    procedure EndStatement(const ABuilder: IMigrationCommandListBuilder);
    procedure Generate(const AOperation: IAddBooleanColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddCheckConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddDateColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddDateTimeColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddFloatColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddForeignKeyOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddGuidColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddIntColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddPrimaryKeyOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddStringColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAddUniqueConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IAlterColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: ICreateIndexOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: ICreateTableOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IDropCheckConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IDropColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IDropForeignKeyOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IDropIndexOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IDropPrimaryKeyOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IDropSchemaOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IDropTableOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IDropUniqueConstraintOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IEnsureSchemaOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: IMigrationOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual;
    procedure Generate(const AOperation: IRenameColumnOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
    procedure Generate(const AOperation: ISqlOperation; const ABuilder: IMigrationCommandListBuilder); overload; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;
    function Generate(const AOperations: IMigrationOperations): IMigrationCommands; overload;
  end;

implementation

uses
{IDE}
  System.Classes,
  System.SysUtils,
  System.RegularExpressions,
  System.TypInfo,
{PROJECT}
  cbsMigrations.Migrations.Operations.AddBooleanColumnOperation,
  cbsMigrations.Migrations.Operations.AddCheckConstraintOperation,
  cbsMigrations.Migrations.Operations.AddDateColumnOperation,
  cbsMigrations.Migrations.Operations.AddDateTimeColumnOperation,
  cbsMigrations.Migrations.Operations.AddFloatColumnOperation,
  cbsMigrations.Migrations.Operations.AddForeignKeyOperation,
  cbsMigrations.Migrations.Operations.AddGuidColumnOperation,
  cbsMigrations.Migrations.Operations.AddIntColumnOperation,
  cbsMigrations.Migrations.Operations.AddPrimaryKeyOperation,
  cbsMigrations.Migrations.Operations.AddStringColumnOperation,
  cbsMigrations.Migrations.Operations.AddUniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.AlterColumnOperation,
  cbsMigrations.Migrations.Operations.CreateIndexOperation,
  cbsMigrations.Migrations.Operations.CreateTableOperation,
  cbsMigrations.Migrations.Operations.DropCheckConstraintOperation,
  cbsMigrations.Migrations.Operations.DropColumnOperation,
  cbsMigrations.Migrations.Operations.DropForeignKeyOperation,
  cbsMigrations.Migrations.Operations.DropIndexOperation,
  cbsMigrations.Migrations.Operations.DropPrimaryKeyOperation,
  cbsMigrations.Migrations.Operations.DropSchemaOperation,
  cbsMigrations.Migrations.Operations.DropTableOperation,
  cbsMigrations.Migrations.Operations.DropUniqueConstraintOperation,
  cbsMigrations.Migrations.Operations.EnsureSchemaOperation,
  cbsMigrations.Migrations.Operations.RenameColumnOperation,
  cbsMigrations.Migrations.Operations.SqlOperation,
  cbsMigrations.Migrations.MigrationCommandListBuilder;

{ TMigrationsSqlGeneratorBase }

constructor TMigrationsSqlGeneratorBase.Create;
begin
  inherited Create;
  FGenerateActions := CreateGenerateActionList;
  FGenerateActions.Add(IAddBooleanColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddBooleanColumnOperation(O), B);
    end);
  FGenerateActions.Add(IAddCheckConstraintOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddCheckConstraintOperation(O), B);
    end);
  FGenerateActions.Add(IAddDateColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddDateColumnOperation(O), B);
    end);
  FGenerateActions.Add(IAddDateTimeColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddDateTimeColumnOperation(O), B);
    end);
  FGenerateActions.Add(IAddFloatColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddFloatColumnOperation(O), B);
    end);
  FGenerateActions.Add(IAddForeignKeyOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddForeignKeyOperation(O), B);
    end);
  FGenerateActions.Add(IAddGuidColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddGuidColumnOperation(O), B);
    end);
  FGenerateActions.Add(IAddIntColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddIntColumnOperation(O), B);
    end);
  FGenerateActions.Add(IAddPrimaryKeyOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddPrimaryKeyOperation(O), B);
    end);
  FGenerateActions.Add(IAddStringColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddStringColumnOperation(O), B);
    end);
  FGenerateActions.Add(IAddUniqueConstraintOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAddUniqueConstraintOperation(O), B);
    end);
  FGenerateActions.Add(IAlterColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TAlterColumnOperation(O), B);
    end);
  FGenerateActions.Add(ICreateIndexOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TCreateIndexOperation(O), B);
    end);
  FGenerateActions.Add(ICreateTableOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TCreateTableOperation(O), B);
    end);
  FGenerateActions.Add(IDropCheckConstraintOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TDropCheckConstraintOperation(O), B);
    end);
  FGenerateActions.Add(IDropColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TDropColumnOperation(O), B);
    end);
  FGenerateActions.Add(IDropForeignKeyOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TDropForeignKeyOperation(O), B);
    end);
  FGenerateActions.Add(IDropIndexOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TDropIndexOperation(O), B);
    end);
  FGenerateActions.Add(IDropPrimaryKeyOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TDropPrimaryKeyOperation(O), B);
    end);
  FGenerateActions.Add(IDropSchemaOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TDropSchemaOperation(O), B);
    end);
  FGenerateActions.Add(IDropTableOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TDropTableOperation(O), B);
    end);
  FGenerateActions.Add(IDropUniqueConstraintOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TDropUniqueConstraintOperation(O), B);
    end);
  FGenerateActions.Add(IEnsureSchemaOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TEnsureSchemaOperation(O), B);
    end);
  FGenerateActions.Add(IRenameColumnOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TRenameColumnOperation(O), B);
    end);
  FGenerateActions.Add(ISqlOperation,
    procedure(const G: TMigrationsSqlGeneratorBase; const O: IMigrationOperation; const B: IMigrationCommandListBuilder)
    begin
      G.Generate(TSqlOperation(O), B);
    end);
end;

destructor TMigrationsSqlGeneratorBase.Destroy;
begin
  FGenerateActions.Clear;
  FGenerateActions := nil;
  inherited;
end;

function TMigrationsSqlGeneratorBase.ColumnList(const AColumns: TArray<string>): string;
begin
  Result := string.Join(', ', AColumns);
end;

function TMigrationsSqlGeneratorBase.CreateGenerateActionList: IGenerateActions;
begin
  Result := TCollections.CreateDictionary<TGUID, TGenerateAction>;
end;

function TMigrationsSqlGeneratorBase.DelimitIdentifier(const AIdentifier: string): string;
begin
  Result := '"' + EscapeIdentifier(AIdentifier) + '"';
end;

function TMigrationsSqlGeneratorBase.DelimitIdentifier(const AName, ASchema: string): string;
begin
  if ASchema <> '' then
    Result := DelimitIdentifier(ASchema) + '.' + DelimitIdentifier(AName)
  else
    Result := DelimitIdentifier(AName);
end;

function TMigrationsSqlGeneratorBase.EscapeIdentifier(const AIdentifier: string): string;
begin
  Result := StringReplace(AIdentifier, '"', '""', [rfReplaceAll]);
end;

function TMigrationsSqlGeneratorBase.Generate(const AOperations: IMigrationOperations): IMigrationCommands;
var
  LBuilder: IMigrationCommandListBuilder;
  LCommandList: ICommandList;
  LOperation: IMigrationOperation;
begin
  LBuilder := TMigrationCommandListBuilder.Create;
  for LOperation in AOperations do
  begin
    Generate(LOperation, LBuilder);
  end;
  LCommandList := CreateCommandList;
  LCommandList.AddRange(LBuilder.CommandList);
  Result := LCommandList;
end;

function TMigrationsSqlGeneratorBase.NormalizeTheSQLScript(const AScript: string): string;
var
  I: Integer;
  LCleanScript: string;
  LLine: string;
  LStringList: TStringList;
begin
  LCleanScript := TRegEx.Replace(AScript, '/\*.*?\*/', '', [roSingleLine, roIgnoreCase]);
  LCleanScript := TRegEx.Replace(LCleanScript, '--.*$', '', [roMultiline]);
  LStringList := TStringList.Create;
  try
    LStringList.Text := LCleanScript;
    for I := LStringList.Count - 1 downto 0 do
    begin
      LLine := Trim(LStringList[I]);
      if LLine = '' then
        LStringList.Delete(I)
      else
      begin
        LLine := StringReplace(LLine, #9, ' ', [rfReplaceAll]);
        LStringList[I] := LLine;
      end;
    end;
    Result := LStringList.Text.Replace(sLineBreak, ' ', [rfReplaceAll]);
    while Pos('  ', Result) > 0 do
    begin
      Result := StringReplace(Result, '  ', ' ', [rfReplaceAll]);
    end;
    Result := Trim(Result);
  finally
    LStringList.Free;
  end;
end;

procedure TMigrationsSqlGeneratorBase.Generate(const AOperation: IMigrationOperation;
  const ABuilder: IMigrationCommandListBuilder);
var
  LType: TGUID;
begin
  AOperation.Prepare;
  LType := FGenerateActions.Keys
   .FirstOrDefault(
     function(const AType: TGUID): Boolean
     begin
       Result := Supports(AOperation, AType);
     end);
  if not(LType = TGUID.Empty) then
  begin
    FGenerateActions[LType](Self, AOperation, ABuilder);
  end;
end;

procedure TMigrationsSqlGeneratorBase.EndStatement(const ABuilder: IMigrationCommandListBuilder);
begin
  ABuilder.EndCommand;
end;

end.
