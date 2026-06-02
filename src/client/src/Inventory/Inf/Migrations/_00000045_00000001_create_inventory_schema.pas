unit _00000045_00000001_create_inventory_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateInventorySchema = class(TMigration)
  private
    const SchemaName = 'inventory';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateInventorySchema }

procedure CreateInventorySchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateInventorySchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName)
end;

initialization
begin
  RegisterMigration(TDbContext, CreateInventorySchema);
end;

end.
