unit _2025_12_09_00000010_create_address_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressSchema = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressSchema }

procedure CreateAddressSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema('address');
end;

procedure CreateAddressSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema('address')
end;

end.
