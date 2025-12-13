unit _2025_12_09_00000021_create_domain_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateDomainSchema = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateDomainSchema }

procedure CreateDomainSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema('domain');
end;

procedure CreateDomainSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema('domain')
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateDomainSchema);
end;

end.
