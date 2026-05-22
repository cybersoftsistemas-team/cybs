unit _00000300_00000100_create_domain_domains_table;

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
  Shared.Inf.Database.Context;

{ CreateDomainDomainsTable }

procedure CreateDomainDomainsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
   ,BooleanColumn('Reserved').IsRequired
   ,GuidColumn('ManagedById').IsOptional
   ,GuidColumn('ParentId').IsOptional
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('ManagedById', 'persons', 'Id').HasPrincipalSchema('person')
   ,ForeignKey('ParentId', TableName, 'Id')
   ,Unique(['ParentId', 'Name'])
   ,CheckConstraint(Format('chk_%s_%s_no_self_parent', [SchemaName, TableName]), '(ParentId IS NULL OR ParentId <> Id)')
  ])
  .Indexes([
    CreateIndex('ManagedById')
   ,CreateIndex('ParentId')
   ,CreateIndex(['ParentId', 'Id'])
  ]);

  ASchema.AddDefault('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');

  ASchema.AddDefault('Reserved')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('0');
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
