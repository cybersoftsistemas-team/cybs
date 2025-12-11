unit _2025_12_08_00000075_create_people_person_addresses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeoplePersonAddressesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeoplePersonAddressesTable }

procedure CreatePeoplePersonAddressesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('person_addresses')
   .HasSchema('people')
   .Columns([
     GuidColumn('PersonId').IsRequired
    ,GuidColumn('PersonType').IsRequired
    ,GuidColumn('AddressId').IsRequired
    ,StringColumn('AdditionalInformation').HasMaxLength(255).IsOptional
    ,BooleanColumn('Correspondence').HasDefaultValueSql('0').IsRequired
    ,IntColumn('Number').HasDefaultValueSql('0').IsRequired
   ])
   .Constraints([
     PrimaryKey(['PersonId', 'PersonType'])
    ,ForeignKey('AddressId', 'addresses', 'Id').HasPrincipalSchema('address')
    ,ForeignKey('PersonId', 'persons', 'Id')
    ,ForeignKey('PersonType', 'categories', 'Id').HasPrincipalSchema('auxiliary_data')
   ]);
end;

procedure CreatePeoplePersonAddressesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('person_addresses')
   .HasSchema('people');
end;

end.
