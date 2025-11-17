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
    procedure CreateRepository(const ATable: string); override;
  public
    function GetLastBatchNumber(const ATable: string): Integer; override;
    function GetRan(const ATable: string): TArray<string>; override;
    procedure CreateIfNotExists(const ATable: string); override;
    procedure RunPending(const AMigrationTypes: TArray<TClass>; const ATable: string); override;
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

procedure TFDBuilder.RunPending(const AMigrationTypes: TArray<TClass>; const ATable: string);
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

procedure TFDBuilder.CreateIfNotExists(const ATable: string);
begin
  if not HasTable(ATable) then
  begin
    CreateRepository(ATable);
  end;
end;

procedure TFDBuilder.CreateRepository(const ATable: string);
begin
  Resolver.CreateCommandExecutor.ExecuteNonQuery(Grammar.CompileCreateRepository(Resolver.DriverID, ATable));
end;

end.
