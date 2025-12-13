unit _2025_12_09_00000025_create_domain_domains_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateDomainDomainsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateDomainDomainsTable }

procedure CreateDomainDomainsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('domains')
   .HasSchema('domain')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
    ,GuidColumn('ManagedById').IsOptional
    ,GuidColumn('ParentId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('ManagedById', 'persons', 'Id').HasPrincipalSchema('person')
    ,ForeignKey('ParentId', 'domains', 'Id')
   ])
   .Indexes([
     CreateIndex('ParentId')
    ,CreateIndex(['ParentId', 'Id'])
   ]);
end;

procedure CreateDomainDomainsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('domains')
   .HasSchema('domain');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateDomainDomainsTable);
end;

end.
