unit _2025_12_08_00000045_create_address_addresses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressAddressesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressAddressesTable }

procedure CreateAddressAddressesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('addresses')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,IntColumn('ZipCode').IsRequired
    ,GuidColumn('StreetTypeId').IsRequired
    ,GuidColumn('StreetId').IsRequired
    ,GuidColumn('NeighborhoodId').IsRequired
    ,GuidColumn('CityId').IsRequired
    ,GuidColumn('StateId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CityId', 'cities', 'Id')
    ,ForeignKey('NeighborhoodId', 'neighborhoods', 'Id')
    ,ForeignKey('StateId', 'states', 'Id')
    ,ForeignKey('StreetId', 'streets', 'Id')
    ,ForeignKey('StreetTypeId', 'streettypes', 'Id')
    ,Unique(['StreetTypeId', 'StreetId', 'NeighborhoodId', 'CityId', 'StateId'])
   ])
   .Indexes([
     CreateIndex('ZipCode')
   ]);
end;

procedure CreateAddressAddressesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('addresses')
   .HasSchema('address');
end;

end.
