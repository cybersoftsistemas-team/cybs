unit _00000050_00000500_create_inventory_transactions_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateInventoryTransactionsTable = class(TMigration)
  private
    const SchemaName = 'inventory';
    const TableName  = 'transactions';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateInventoryTransactionsTable }

procedure CreateInventoryTransactionsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,IntColumn('Sequence').HasColumnType('BIGINT').HasIncrement().IsRequired
   ,GuidColumn('WarehouseId').IsRequired
   ,GuidColumn('LotId').IsOptional
   ,GuidColumn('VariantId').IsRequired
   ,GuidColumn('TransactionTypeId').IsRequired
   ,DateTimeColumn('TransactionDate').HasDefaultValueSql('GETDATE()').IsRequired
   ,DecimalColumn('Quantity').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,DecimalColumn('ConvertedQuantity').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,GuidColumn('UnitMeasureId').IsRequired
   ,DecimalColumn('BalanceBefore').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,DecimalColumn('BalanceAfter').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,GuidColumn('ReferenceTypeId').IsRequired
   ,GuidColumn('ReferenceId').IsRequired
   ,StringColumn('Notes').IsMaxLength.IsUnicode.IsOptional
   ,DateTimeColumn('CreatedAt').HasDefaultValueSql('GETDATE()').IsRequired
   ,StringColumn('CreatedBy').HasMaxLength(100).IsUnicode.IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('WarehouseId', 'warehouses', 'Id')
   ,ForeignKey('LotId', 'lots', 'Id')
   ,ForeignKey('VariantId', 'variants', 'Id').HasPrincipalSchema('catalog')
   ,ForeignKey('TransactionTypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ,ForeignKey('UnitMeasureId', 'unit_measures', 'Id').HasPrincipalSchema('catalog')
   ,ForeignKey('ReferenceTypeId', 'categories', 'Id').HasPrincipalSchema('general')
  ])
  .Indexes([
    CreateIndex('Sequence').IsUnique
   ,CreateIndex('WarehouseId')
   ,CreateIndex('LotId')
   ,CreateIndex('VariantId')
   ,CreateIndex('TransactionTypeId')
   ,CreateIndex('UnitMeasureId')
   ,CreateIndex('ReferenceTypeId')
   ,CreateIndex('TransactionDate')
   ,CreateIndex(['WarehouseId', 'VariantId'])
   ,CreateIndex(['WarehouseId', 'LotId'])
   ,CreateIndex(['VariantId', 'TransactionDate'])
   ,CreateIndex(['LotId', 'TransactionDate'])
   ,CreateIndex(['ReferenceTypeId', 'ReferenceId'])
  ]);
end;

procedure CreateInventoryTransactionsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateInventoryTransactionsTable);
end;

end.
