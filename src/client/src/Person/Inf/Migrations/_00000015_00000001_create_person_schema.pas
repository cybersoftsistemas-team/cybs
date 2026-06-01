unit _00000015_00000001_create_person_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonSchema = class(TMigration)
  private
    const SchemaName = 'person';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreatePersonSchema }

procedure CreatePersonSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreatePersonSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreatePersonSchema);
end;

end.
