unit _2025_12_09_00000030_create_address_neighborhoods_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressNeighborhoodsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressNeighborhoodsTable }

procedure CreateAddressNeighborhoodsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('neighborhoods')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,GuidColumn('CityId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CityId', 'cities', 'Id')
    ,Unique(['CityId', 'Name'])
   ]);
end;

procedure CreateAddressNeighborhoodsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('neighborhoods')
   .HasSchema('address');
end;

end.
