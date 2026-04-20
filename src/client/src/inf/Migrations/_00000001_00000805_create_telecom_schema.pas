unit _00000001_00000805_create_telecom_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateTelecomSchema = class(TMigration)
  private
    const SchemaName = 'telecom';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateTelecomSchema }

procedure CreateTelecomSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateTelecomSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

end.
