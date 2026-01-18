unit _00000001_00001100_create_address_neighborhoods_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressNeighborhoodsTable = class(TMigration)
  private
    const TableName = 'neighborhoods';
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressNeighborhoodsTable }

procedure CreateAddressNeighborhoodsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,GuidColumn('CityId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CityId', 'cities', 'Id')
    ,Unique(['CityId', 'Name'])
   ])
   .Indexes([
     CreateIndex('CityId')
   ]);
end;

procedure CreateAddressNeighborhoodsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
