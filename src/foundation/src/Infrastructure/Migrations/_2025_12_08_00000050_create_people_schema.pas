unit _2025_12_08_00000050_create_people_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeopleSchema = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeopleSchema }

procedure CreatePeopleSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema('people');
end;

procedure CreatePeopleSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema('people')
end;

end.
