unit _00000100_00000500_create_address_neighborhoods_table;

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

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateAddressNeighborhoodsTable }

procedure CreateAddressNeighborhoodsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
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

  ASchema.AddDefaultValue('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');
end;

procedure CreateAddressNeighborhoodsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateAddressNeighborhoodsTable);
end;

end.
