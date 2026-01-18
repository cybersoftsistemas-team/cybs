unit _00001000_00000900_create_registration_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateRegistrationSchema = class(TMigration)
  private
    const SchemaName = 'registration';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateRegistrationSchema }

procedure CreateRegistrationSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateRegistrationSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName)
end;

initialization
begin
  RegisterMigration(TDbContext, CreateRegistrationSchema);
end;

end.
