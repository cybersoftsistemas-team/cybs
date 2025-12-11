unit _2025_12_09_00000030_create_identity_domain_accesses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityDomainAccessesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentityDomainAccessesTable }

procedure CreateIdentityDomainAccessesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('domain_accesses')
   .HasSchema('identity')
   .Columns([
     GuidColumn('DomainId').IsRequired
    ,GuidColumn('UserId').IsRequired
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
   ])
   .Constraints([
     PrimaryKey(['DomainId', 'UserId'])
    ,ForeignKey('DomainId', 'domains', 'Id')
    ,ForeignKey('UserId', 'user_authentications', 'Id')
   ]);
end;

procedure CreateIdentityDomainAccessesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('domain_accesses')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentityDomainAccessesTable);
end;

end.
