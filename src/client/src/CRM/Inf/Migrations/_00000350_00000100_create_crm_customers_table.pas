unit _00000350_00000100_create_crm_customers_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCrmCustomersTable = class(TMigration)
  private
    const TableName = 'customers';
    const SchemaName = 'crm';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCrmCustomersTable }

procedure CreateCrmCustomersTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,BooleanColumn('Active').IsRequired
   ,GuidColumn('DomainId').IsRequired
   ,GuidColumn('CustomersId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('CustomersId', 'persons', 'Id').HasPrincipalSchema('person')
   ,ForeignKey('DomainId', 'domains', 'Id').HasPrincipalSchema('domain')
  ])
  .Indexes([
    CreateIndex('CustomersId')
   ,CreateIndex('DomainId')
   ,CreateIndex(['DomainId', 'CustomersId'], True)
    .HasInclude('Active')
  ]);

  ASchema.AddDefault('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');

  ASchema.AddDefault('Active')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('0');
end;

procedure CreateCrmCustomersTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCrmCustomersTable);
end;

end.
