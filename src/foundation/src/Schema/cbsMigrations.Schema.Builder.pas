unit cbsMigrations.Schema.Builder;

interface

uses
{IDE}
  Data.DB,
{PROJECT}
  cbsMigrations.Contracts.Migrations.ConnectionResolver,
  cbsMigrations.Contracts.Schema.Builder,
  cbsMigrations.Contracts.Schema.Grammars.Grammar,
  cbsMigrations.Contracts.Schema.SchemaAndTableParts;

type
  TBuilder = class abstract(TInterfacedObject, IBuilder)
  private
    FGrammar: IGrammar;
    FResolver: IConnectionResolver;
  protected
    function GetGrammar: IGrammar;
    function GetInternalSchemaGrammar: IGrammar; virtual; abstract;
    function GetLastBatchNumber(const ADataSet: TDataSet): Integer; overload;
    function GetRan(const ADataSet: TDataSet): TArray<string>; overload;
    function HasTable(const ADataSet: TDataSet): Boolean; overload;
    function ParseSchemaAndTable(const AReference: string): ISchemaAndTableParts;
    procedure CreateRepository(const ATable: string); virtual; abstract;
    property Resolver: IConnectionResolver read FResolver;
  public
    constructor Create(const AResolver: IConnectionResolver);
    destructor Destroy; override;
    function GetLastBatchNumber(const ATable: string): Integer; overload; virtual; abstract;
    function GetRan(const ATable: string): TArray<string>; overload; virtual; abstract;
    function HasTable(const ATable: string): Boolean; overload; virtual; abstract;
    procedure CreateIfNotExists(const ATable: string); virtual; abstract;
    procedure RunPending(const AMigrationTypes: TArray<TClass>; const ATable: string); virtual; abstract;
    property Grammar: IGrammar read GetGrammar;
  end;

  BuilderType = class of TBuilder;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMigrations.Schema.SchemaAndTableParts,
  cbsMigrations.Schema.Types;

{ TBuilder }

constructor TBuilder.Create(const AResolver: IConnectionResolver);
begin
  inherited Create;
  FResolver := AResolver;
end;

destructor TBuilder.Destroy;
begin
  FResolver := nil;
  FGrammar := nil;
  inherited;
end;

function TBuilder.GetGrammar: IGrammar;
begin
  if not Assigned(FGrammar) then
  begin
    FGrammar := GetInternalSchemaGrammar;
  end;
  Result := FGrammar;
end;

function TBuilder.GetLastBatchNumber(const ADataSet: TDataSet): Integer;
begin
  Result := ADataSet.FieldByName('Batch').AsInteger;
end;

function TBuilder.GetRan(const ADataSet: TDataSet): TArray<string>;
begin
  Result := [];
  ADataSet.First;
  while not ADataSet.Eof do
  begin
    Result := Result + [ADataSet.FieldByName('Migration').AsString];
    ADataSet.Next;
  end;
end;

function TBuilder.HasTable(const ADataSet: TDataSet): Boolean;
begin
  Result := not ADataSet.IsEmpty and ADataSet.FieldByName('EXISTS').AsBoolean;
end;

function TBuilder.ParseSchemaAndTable(const AReference: string): ISchemaAndTableParts;
var
  LDotIndex: Integer;
  LSchema: TSchema;
  LTable: TTable;
begin
  LDotIndex := Pos('.', AReference);
  if LDotIndex > 0 then
  begin
    LSchema := Copy(AReference, 1, LDotIndex - 1);
    LTable := Copy(AReference, LDotIndex + 1, MaxInt);
  end
  else
  begin
    LSchema := '';
    LTable := AReference;
  end;
  if Pos('.', LTable) > 0 then
  begin
    raise Exception.CreateFmt(
      'Using three-part reference is not supported, you may use Schema.Connection(''%s'') instead.',
      [LSchema]
    );
  end;
  Result := TSchemaAndTableParts.Create(LSchema, LTable);
end;

end.
