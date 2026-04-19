unit _00000001_00001400_create_address_addresses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressAddressesTable = class(TMigration)
  private
    const TableName = 'addresses';
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressAddressesTable }

procedure CreateAddressAddressesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
    ,StringColumn('ZipCode').HasMaxLength(8).HasUnicode(True).IsFixedLength.IsRequired
    ,GuidColumn('StreetTypeId').IsRequired
    ,GuidColumn('StreetId').IsRequired
    ,GuidColumn('NeighborhoodId').IsRequired
    ,GuidColumn('CityId').IsRequired
    ,GuidColumn('StateId').IsRequired
    ,ComputedColumn('AddressHash')
     .HasSqlAs(
      'HASHBYTES(' +
      '  ''SHA2_256'',' +
      '  CONCAT(' +
      '    CAST(StreetTypeId AS BINARY(16)),' +
      '    CAST(StreetId AS BINARY(16)),' +
      '    CAST(NeighborhoodId AS BINARY(16)),' +
      '    CAST(CityId AS BINARY(16)),' +
      '    CAST(StateId AS BINARY(16))' +
      '  )' +
      ')')
     .IsOptional
     .IsStored
    ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CityId', 'cities', 'Id')
    ,ForeignKey('NeighborhoodId', 'neighborhoods', 'Id')
    ,ForeignKey('StateId', 'states', 'Id')
    ,ForeignKey('StreetId', 'streets', 'Id')
    ,ForeignKey('StreetTypeId', 'streettypes', 'Id')
    ])
   .Indexes([
     CreateIndex('CityId')
    ,CreateIndex('NeighborhoodId')
    ,CreateIndex('StateId')
    ,CreateIndex('StreetId')
    ,CreateIndex('StreetTypeId')
    ,CreateIndex('ZipCode')
    ,CreateIndex('AddressHash', True)
     .HasInclude([
      'StreetTypeId',
      'StreetId',
      'NeighborhoodId',
      'CityId',
      'StateId'
      ])
    ]);
end;

procedure CreateAddressAddressesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
