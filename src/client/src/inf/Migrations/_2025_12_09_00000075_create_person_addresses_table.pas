unit _2025_12_09_00000075_create_person_addresses_table;

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

{ CreatePersonAddressesTable }

procedure CreatePersonAddressesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('PersonId').IsRequired
    ,GuidColumn('TypeId').IsRequired
    ,GuidColumn('AddressId').IsRequired
    ,StringColumn('AdditionalInformation').HasMaxLength(255).IsOptional
    ,BooleanColumn('Correspondence').HasDefaultValueSql('0').IsRequired
    ,IntColumn('Number').HasDefaultValueSql('0').IsRequired
   ])
   .Constraints([
     PrimaryKey(['PersonId', 'TypeId'])
    ,ForeignKey('AddressId', 'addresses', 'Id').HasPrincipalSchema('address')
    ,ForeignKey('PersonId', 'persons', 'Id')
    ,ForeignKey('TypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ])
   .Indexes([
     CreateIndex('AddressId')
    ,CreateIndex('PersonId')
    ,CreateIndex('TypeId')
   ]);
end;

procedure CreatePersonAddressesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
