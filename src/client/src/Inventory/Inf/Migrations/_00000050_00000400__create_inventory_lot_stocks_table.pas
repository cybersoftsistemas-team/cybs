unit _00000050_00000400__create_inventory_lot_stocks_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateInventoryLotStocksTable = class(TMigration)
  private
    const SchemaName = 'inventory';
    const TableName  = 'lot_stocks';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateInventoryLotStocksTable }

procedure CreateInventoryLotStocksTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,GuidColumn('WarehouseId').IsRequired
   ,GuidColumn('LotId').IsRequired
   ,DecimalColumn('CurrentStock').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,DecimalColumn('ReservedStock').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('WarehouseId', 'warehouses', 'Id')
   ,ForeignKey('LotId', 'lots', 'Id')
   ,Unique(['WarehouseId', 'LotId'])
  ])
  .Indexes([
    CreateIndex('WarehouseId')
   ,CreateIndex('LotId')
  ]);
end;

procedure CreateInventoryLotStocksTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateInventoryLotStocksTable);
end;

end.
