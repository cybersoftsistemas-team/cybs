unit _00000035_00000200_create_crm_manufacturers_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateManufacturersTable = class(TMigration)
  private
    const SchemaName = 'crm';
    const TableName  = 'manufacturers';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateManufacturersTable }

procedure CreateManufacturersTable.Up(const ASchema: IMigrationBuilder);
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

procedure CreateManufacturersTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateManufacturersTable);
end;

end.
