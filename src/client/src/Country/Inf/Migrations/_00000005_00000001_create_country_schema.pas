unit _00000005_00000001_create_country_schema;

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

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCountrySchema }

procedure CreateCountrySchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateCountrySchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCountrySchema);
end;

end.
