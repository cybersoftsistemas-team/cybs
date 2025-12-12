unit cbsMigrationsFireDac.Schema.Builder;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Schema.Grammars.Grammar,
  cbsMigrations.Schema.Builder,
  cbsMigrationsFireDac.Contracts.Schema.Builder,
  cbsMigrationsFireDac.Contracts.Migrations.ConnectionResolver;

type
  TFDBuilder = class(TBuilder, IFDBuilder)
  private
    function GetResolver: IFDConnectionResolver;
    function GetNextBatchNumber(const ATable: string): Integer;
  protected
    function GetInternalSchemaGrammar: IGrammar; override;
    procedure CreateRepository(const ASchema, ATable: string); override;
    procedure CreateSchema(const AName: string); override;
  public
    function GetLastBatchNumber(const ATable: string): Integer; override;
    function GetRan(const ATable: string): TArray<string>; override;
    procedure CreateIfNotExists(const ASchema, ATable: string); override;
    procedure RunPending(const AMigrationTypes: TArray<TClass>; const ASchema, ATable: string); override;
    property Resolver: IFDConnectionResolver read GetResolver;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder,
  cbsMigrations.Schema.Grammars.SqlServerGrammar,
  cbsMigrationsFireDac.Migrations.ConnectionResolver;

{ TFDBuilder }

function TFDBuilder.GetInternalSchemaGrammar: IGrammar;
begin
  Result := TSqlServerGrammar.Create;
end;

function TFDBuilder.GetLastBatchNumber(const ATable: string): Integer;
begin
  var LParts := ParseSchemaAndTable(ATable);
  var LSelCommand := Resolver.CreateCommand;
  try
    LSelCommand.Open(Grammar.CompileGetLastBatchNumber(LParts.Schema, LParts.Table).CommandText);
    Result := inherited GetLastBatchNumber(LSelCommand);
  finally
    FreeAndNil(LSelCommand);
  end;
end;

function TFDBuilder.GetNextBatchNumber(const ATable: string): Integer;
begin
  Result := GetLastBatchNumber(ATable) + 1;
end;

function TFDBuilder.GetRan(const ATable: string): TArray<string>;
begin
  var LParts := ParseSchemaAndTable(ATable);
  var LSelCommand := Resolver.CreateCommand;
  try
    LSelCommand.Open(Grammar.CompileGetRan(LParts.Schema, LParts.Table).CommandText);
    Result := inherited GetRan(LSelCommand);
  finally
    FreeAndNil(LSelCommand);
  end;
end;

function TFDBuilder.GetResolver: IFDConnectionResolver;
begin
  Result := TFDConnectionResolver(inherited Resolver);
end;

procedure TFDBuilder.RunPending(const AMigrationTypes: TArray<TClass>; const ASchema, ATable: string);
var
  LCommandList: ICommandList;
begin
  if Low(AMigrationTypes) < Length(AMigrationTypes) then
  begin
    LCommandList := CreateCommandList;
    LCommandList.AddRange(Grammar.CompileRunPending(Resolver.DriverID, AMigrationTypes, GetNextBatchNumber(ATable), ATable));
    Resolver.CreateCommandExecutor.ExecuteNonQuery(LCommandList);
  end;
end;

procedure TFDBuilder.CreateIfNotExists(const ASchema: string; const ATable: string);
begin
  if not HasTable(concat(ASchema, '.', ATable)) then
  begin
    CreateSchema(ASchema);
    CreateRepository(ASchema, ATable);
  end;
end;

procedure TFDBuilder.CreateRepository(const ASchema, ATable: string);
begin
  Resolver.CreateCommandExecutor.ExecuteNonQuery(Grammar.CompileCreateRepository(Resolver.DriverID, ASchema, ATable));
end;

procedure TFDBuilder.CreateSchema(const AName: string);
begin
  Resolver.CreateCommandExecutor.ExecuteNonQuery(Grammar.CompileCreateSchema(Resolver.DriverID, AName));
end;

end.
