unit _2025_12_09_00000035_create_identity_domains_persons_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityDomainsPersonsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentityDomainsPersonsTable }

procedure CreateIdentityDomainsPersonsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('domains_persons')
   .HasSchema('identity')
   .Columns([
     GuidColumn('DomainId').IsRequired
    ,GuidColumn('PersonId').IsRequired
   ])
   .Constraints([
     PrimaryKey(['DomainId', 'PersonId'])
    ,ForeignKey('DomainId', 'domains', 'Id')
    ,ForeignKey('PersonId', 'persons', 'Id')
   ]);
end;

procedure CreateIdentityDomainsPersonsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('domains_persons')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentityDomainsPersonsTable);
end;

end.
