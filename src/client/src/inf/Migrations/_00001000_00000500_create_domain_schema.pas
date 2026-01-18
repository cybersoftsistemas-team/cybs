unit _00001000_00000500_create_domain_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateDomainSchema = class(TMigration)
  private
    const SchemaName = 'domain';
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
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateDomainSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName)
end;

initialization
begin
  RegisterMigration(TDbContext, CreateDomainSchema);
end;

end.
