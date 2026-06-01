unit _00000040_00000001_create_catalog_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogSchema = class(TMigration)
  private
    const SchemaName = 'catalog';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogSchema }

procedure CreateCatalogSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateCatalogSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName)
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogSchema);
end;

end.
