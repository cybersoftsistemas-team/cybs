unit _00000001_00000001_create_general_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateGeneralSchema = class(TMigration)
  private
    const SchemaName = 'general';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateGeneralSchema }

procedure CreateGeneralSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateGeneralSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

end.
