unit _2025_12_09_00000050_create_person_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonSchema = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreatePersonSchema }

procedure CreatePersonSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema('person');
end;

procedure CreatePersonSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema('person')
end;

initialization
begin
  RegisterMigration(TDbContext, CreatePersonSchema);
end;

end.
