unit _00000035_00000300_create_crm_suppliers_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCrmSuppliersTable = class(TMigration)
  private
    const SchemaName = 'crm';
    const TableName  = 'suppliers';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCrmSuppliersTable }

procedure CreateCrmSuppliersTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,BooleanColumn('Active').HasDefaultValueSql('1').IsRequired
   ,GuidColumn('DomainId').IsRequired
   ,GuidColumn('PersonId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('DomainId', 'domains', 'Id').HasPrincipalSchema('domain')
   ,ForeignKey('PersonId', 'persons', 'Id').HasPrincipalSchema('person')
  ])
  .Indexes([
    CreateIndex('DomainId')
   ,CreateIndex('PersonId')
   ,CreateIndex(['DomainId', 'PersonId'])
    .HasInclude('Active')
    .IsUnique()
  ]);
end;

procedure CreateCrmSuppliersTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCrmSuppliersTable);
end;

end.
