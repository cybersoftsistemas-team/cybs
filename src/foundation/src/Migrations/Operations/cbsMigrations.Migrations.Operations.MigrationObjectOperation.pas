unit cbsMigrations.Migrations.Operations.MigrationObjectOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.MigrationObjectOperation,
  cbsMigrations.Migrations.Operations.MigrationOperation;

type
  TMigrationObjectOperation = class abstract(TMigrationOperation, IMigrationObjectOperation)
  private
    FSchema: string;
    FTable: string;
    function GetSchema: string;
    function GetTable: string;
  protected
    function QualifiedTableName(const ATable, ASchema: string; const ASeparator: Char): string; overload;
    procedure SetSchema(const AValue: string);
    procedure SetTable(const AValue: string);
  public
    function QualifiedTableName(const ASeparator: Char = #0): string; overload;
    property Schema: string read GetSchema;
    property Table: string read GetTable;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TMigrationObjectOperation }

function TMigrationObjectOperation.GetSchema: string;
begin
  Result := FSchema;
end;

function TMigrationObjectOperation.GetTable: string;
begin
  Result := FTable;
end;

function TMigrationObjectOperation.QualifiedTableName(const ATable, ASchema: string; const ASeparator: Char): string;
var
  LSeparator: Char;
begin
  Result := ATable;
  LSeparator := ASeparator;
  if LSeparator = #0 then
  begin
    LSeparator := '.';
  end;
  if not ASchema.Trim.IsEmpty then
  begin
    Result := ASchema + LSeparator + ATable;
  end;
end;

function TMigrationObjectOperation.QualifiedTableName(const ASeparator: Char): string;
begin
  Result := QualifiedTableName(FTable, FSchema, ASeparator);
end;

procedure TMigrationObjectOperation.SetSchema(const AValue: string);
begin
  FSchema := AValue;
end;

procedure TMigrationObjectOperation.SetTable(const AValue: string);
begin
  FTable := AValue;
end;

end.
