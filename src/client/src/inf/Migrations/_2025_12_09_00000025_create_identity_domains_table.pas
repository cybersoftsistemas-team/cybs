unit _2025_12_09_00000025_create_identity_domains_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityDomainsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentityDomainsTable }

procedure CreateIdentityDomainsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('domains')
   .HasSchema('identity')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
    ,GuidColumn('ManagedById').IsOptional
    ,GuidColumn('ParentId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('ManagedById', 'persons', 'Id').HasPrincipalSchema('people')
    ,ForeignKey('ParentId', 'domains', 'Id')
   ])
   .Indexes([
     CreateIndex('ParentId')
    ,CreateIndex(['ParentId', 'Id'])
   ]);
end;

procedure CreateIdentityDomainsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('domains')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentityDomainsTable);
end;

end.
