unit _2025_12_09_00000050_create_person_schema;

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

{ CreatePersonSchema }

procedure CreatePersonSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreatePersonSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

end.
