unit _00000100_00000001_create_address_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressSchema = class(TMigration)
  private
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateAddressSchema }

procedure CreateAddressSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateAddressSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateAddressSchema);
end;

end.
