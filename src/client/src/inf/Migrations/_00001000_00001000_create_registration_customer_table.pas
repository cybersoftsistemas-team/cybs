unit _00001000_00001000_create_registration_customer_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateRegistrationCustomerTable = class(TMigration)
  private
    const TableName = 'customer';
    const SchemaName = 'registration';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateRegistrationCustomerTable }

procedure CreateRegistrationCustomerTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     IntColumn('Id').HasDefaultValueSql('1').IsRequired
    ,GuidColumn('CustomerId').IsRequired
    ,GuidColumn('ClientId').IsRequired
    ,DateTimeColumn('CreatedAt').HasDefaultValueSql('GETDATE()').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CustomerId', 'persons', 'Id').HasPrincipalSchema('person')
    ,CheckConstraint('chk_registration_customer_singleton', '(Id = 1)')
   ])
   .Indexes([
     CreateIndex('ClientId')
    ,CreateIndex('CustomerId')
   ]);
end;

procedure CreateRegistrationCustomerTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateRegistrationCustomerTable);
end;

end.
