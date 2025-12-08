unit _2025_11_17_00000005_create_identity_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentitySchema = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentitySchema }

procedure CreateIdentitySchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema('identity');
end;

procedure CreateIdentitySchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema('identity')
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentitySchema);
end;

end.
