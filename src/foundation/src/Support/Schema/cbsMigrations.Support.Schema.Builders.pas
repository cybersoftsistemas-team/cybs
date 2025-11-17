unit cbsMigrations.Support.Schema.Builders;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Schema.Builders;

  function SchemaBuilders: IBuilders;

implementation

uses
{PROJECT}
  cbsMigrations.Schema.Builders;

var
  InternalSchemaBuilders: IBuilders;

function SchemaBuilders: IBuilders;
begin
  Result := InternalSchemaBuilders;
end;

initialization
begin
  InternalSchemaBuilders := TBuilders.Create;
end;

finalization
begin
  InternalSchemaBuilders := nil;
end;

end.
