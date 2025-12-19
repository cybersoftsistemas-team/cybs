unit _2025_12_10_00000050_create_registration_customer_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateRegistrationCustomerTable = class(TMigration)
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
  ASchema.CreateTable('customer')
   .HasSchema('registration')
   .Columns([
     IntColumn('Id').HasDefaultValueSql('1').IsRequired
    ,GuidColumn('CustomerId').IsRequired
    ,GuidColumn('ClientId').IsRequired
    ,DateTimeColumn('CreatedAt').HasDefaultValueSql('GETDATE()').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CustomerId', 'persons', 'Id').HasPrincipalSchema('person')
    ,CheckConstraint('CK_registration_customer_singleton', '(Id = 1)')
   ])
   .Indexes([
     CreateIndex('CustomerId')
   ]);
end;

procedure CreateRegistrationCustomerTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('customer')
   .HasSchema('registration');
end;

initialization
begin
  RegisterMigration(TDbContext, CreateRegistrationCustomerTable);
end;

end.
