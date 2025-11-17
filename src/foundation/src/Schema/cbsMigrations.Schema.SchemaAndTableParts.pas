unit cbsMigrations.Schema.SchemaAndTableParts;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Schema.SchemaAndTableParts,
  cbsMigrations.Schema.Types;

type
  TSchemaAndTableParts = class(TInterfacedObject, ISchemaAndTableParts)
  private
    FSchema: TSchema;
    FTable: TTable;
    function GetSchema: TSchema;
    function GetTable: TTable;
  public
    constructor Create(const ASchema: TSchema; const ATable: TTable);
    property Schema: TSchema read GetSchema;
    property Table: TTable read GetTable;
  end;

implementation

{ TSchemaAndTableParts }

constructor TSchemaAndTableParts.Create(const ASchema: TSchema; const ATable: TTable);
begin
  inherited Create;
  FSchema := ASchema;
  FTable := ATable;
end;

function TSchemaAndTableParts.GetSchema: TSchema;
begin
  Result := FSchema;
end;

function TSchemaAndTableParts.GetTable: TTable;
begin
  Result := FTable;
end;

end.
