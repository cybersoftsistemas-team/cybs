unit _00000010_00000800_create_address_addresses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressAddressesTable = class(TMigration)
  private
    const SchemaName = 'address';
    const TableName  = 'addresses';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateAddressAddressesTable }

procedure CreateAddressAddressesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Address').IsUnicode.IsOptional
   ,StringColumn('Number').HasMaxLength(20).IsUnicode.IsOptional
   ,StringColumn('ZipCode').HasMaxLength(8).IsUnicode.IsFixedLength.IsRequired
   ,GuidColumn('StreetTypeId').IsRequired
   ,GuidColumn('StreetId').IsRequired
   ,GuidColumn('NeighborhoodId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('NeighborhoodId', 'neighborhoods', 'Id')
   ,ForeignKey('StreetId', 'streets', 'Id')
   ,ForeignKey('StreetTypeId', 'streettypes', 'Id')
   ,Unique(['ZipCode', 'Number'])
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

initialization
begin
  RegisterMigration(TDbContext, CreateAddressAddressesTable);
end;

end.
