unit _00000050_00000200_create_inventory_inventories_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateInventoryInventoriesTable = class(TMigration)
  private
    const SchemaName = 'inventory';
    const TableName  = 'inventories';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateInventoryInventoriesTable }

procedure CreateInventoryInventoriesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,DecimalColumn('CurrentStock').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,DecimalColumn('MinimumStock').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,DecimalColumn('ReservedStock').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,GuidColumn('WarehouseId').IsRequired
   ,GuidColumn('VariantId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('WarehouseId', 'warehouses', 'Id')
   ,ForeignKey('VariantId', 'variants', 'Id').HasPrincipalSchema('catalog')
   ,Unique(['WarehouseId', 'VariantId'])
  ])
  .Indexes([
    CreateIndex('VariantId')
  ]);
end;

procedure CreateInventoryInventoriesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateInventoryInventoriesTable);
end;

end.
