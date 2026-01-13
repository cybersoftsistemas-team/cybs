unit _2025_12_10_00000001_create_identity_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentitySchema = class(TMigration)
  private
    const SchemaName = 'identity';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateIdentitySchema }

procedure CreateIdentitySchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateIdentitySchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentitySchema);
end;

end.
