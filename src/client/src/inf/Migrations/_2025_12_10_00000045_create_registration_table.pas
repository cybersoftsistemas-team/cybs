unit _2025_12_10_00000045_create_registration_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateRegistrationSchema = class(TMigration)
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
  ASchema.EnsureSchema('registration');
end;

procedure CreateRegistrationSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema('registration')
end;

initialization
begin
  RegisterMigration(TDbContext, CreateRegistrationSchema);
end;

end.
