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
    ,StringColumn('Address').HasUnicode(True).IsOptional
    ,StringColumn('Number').HasMaxLength(20).HasUnicode(True).IsOptional
    ,StringColumn('ZipCode').HasMaxLength(8).HasUnicode(True).IsFixedLength.IsRequired
    ,GuidColumn('StreetTypeId').IsRequired
    ,GuidColumn('StreetId').IsRequired
    ,GuidColumn('NeighborhoodId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('NeighborhoodId', 'neighborhoods', 'Id')
    ,ForeignKey('StreetId', 'streets', 'Id')
    ,ForeignKey('StreetTypeId', 'streettypes', 'Id')
   ])
   .Indexes([
     CreateIndex('NeighborhoodId')
    ,CreateIndex('StreetId')
    ,CreateIndex('StreetTypeId')
    ,CreateIndex('ZipCode')
   ]);
end;

procedure CreateAddressAddressesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
