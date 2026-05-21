unit _00000200_00000400_create_person_addresses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonAddressesTable = class(TMigration)
  private
    const TableName = 'addresses';
    const SchemaName = 'person';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreatePersonAddressesTable }

procedure CreatePersonAddressesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,GuidColumn('PersonId').IsRequired
   ,GuidColumn('TypeId').IsRequired
   ,StringColumn('AdditionalInformation').HasMaxLength(255).IsUnicode.IsOptional
   ,BooleanColumn('Correspondence').IsRequired
   ,GuidColumn('AddressId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('AddressId', 'addresses', 'Id').HasPrincipalSchema('address')
   ,ForeignKey('PersonId', 'persons', 'Id')
   ,ForeignKey('TypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ,Unique(['PersonId', 'TypeId'])
  ])
  .Indexes([
    CreateIndex('AddressId')
   ,CreateIndex('PersonId')
   ,CreateIndex('TypeId')
  ]);

  ASchema.AddDefaultValue('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');

  ASchema.AddDefaultValue('Correspondence')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('0');
end;

procedure CreatePersonAddressesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreatePersonAddressesTable);
end;

end.
