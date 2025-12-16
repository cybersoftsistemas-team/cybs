unit _2025_12_10_00000025_create_domain_schema;

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
  cbsMain.inf.DbContext;

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
  RegisterMigration(TDbContext, CreateDomainSchema);
end;

end.
