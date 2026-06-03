unit _00000050_00000300__create_inventory_lots_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateInventoryLotsTable = class(TMigration)
  private
    const SchemaName = 'inventory';
    const TableName  = 'lots';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateInventoryLotsTable }

procedure CreateInventoryLotsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,GuidColumn('VariantId').IsRequired
   ,StringColumn('LotNumber').HasMaxLength(100).IsUnicode.IsRequired
   ,DateTimeColumn('ManufacturingDate').IsOptional
   ,DateTimeColumn('ExpirationDate').IsOptional
   ,DecimalColumn('CostPrice').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,GuidColumn('SupplierId').IsOptional
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('VariantId', 'variants', 'Id').HasPrincipalSchema('catalog')
   ,ForeignKey('SupplierId', 'suppliers', 'Id').HasPrincipalSchema('crm')
   ,Unique(['VariantId', 'LotNumber'])
  ])
  .Indexes([
    CreateIndex('VariantId')
   ,CreateIndex('SupplierId')
   ,CreateIndex('LotNumber')
   ,CreateIndex('ExpirationDate')
   ,CreateIndex(['VariantId', 'ExpirationDate'])
  ]);
end;

procedure CreateInventoryLotsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateInventoryLotsTable);
end;

end.
