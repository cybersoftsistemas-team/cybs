unit _00000001_00000200_create_country_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCountrySchema = class(TMigration)
  private
    const SchemaName = 'country';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateCountrySchema }

procedure CreateCountrySchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateCountrySchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

end.
