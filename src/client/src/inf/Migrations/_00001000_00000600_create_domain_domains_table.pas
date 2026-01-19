unit _00001000_00000600_create_domain_domains_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateDomainDomainsTable = class(TMigration)
  private
    const TableName = 'domains';
    const SchemaName = 'domain';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateDomainDomainsTable }

procedure CreateDomainDomainsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
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
    ,ForeignKey('ParentId', TableName, 'Id')
    ,CheckConstraint(Format('chk_%s_%s_no_self_parent', [SchemaName, TableName]), '(ParentId IS NULL OR ParentId <> Id)')
   ])
   .Indexes([
     CreateIndex('ManagedById')
    ,CreateIndex('ParentId')
    ,CreateIndex(['ParentId', 'Id'])
   ]);
end;

procedure CreateDomainDomainsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateDomainDomainsTable);
end;

end.
