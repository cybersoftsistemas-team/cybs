unit _00000001_00000600_create_address_schema;

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

{ CreateAddressSchema }

procedure CreateAddressSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateAddressSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

end.
