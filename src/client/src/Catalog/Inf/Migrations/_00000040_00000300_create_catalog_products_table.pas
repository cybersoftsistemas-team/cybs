unit _00000040_00000300_create_catalog_products_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogProductTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'products';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogProductTable }

procedure CreateCatalogProductTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,BooleanColumn('StockControlled').HasDefaultValueSql('0').IsRequired
   ,DecimalColumn('CurrentStock').HasDefaultValueSql('0').HasPrecision(18,4).IsRequired
   ,DecimalColumn('MinimumStock').HasDefaultValueSql('0').HasPrecision(18,4).IsRequired
   ,GuidColumn('NcmId').IsRequired
   ,GuidColumn('PurchaseUnitMeasureId').IsRequired
   ,GuidColumn('SalesUnitMeasureId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('Id', 'items', 'Id')
   ,ForeignKey('PurchaseUnitMeasureId', 'unit_measures', 'Id')
   ,ForeignKey('SalesUnitMeasureId', 'unit_measures', 'Id')
  ])
  .Indexes([
    CreateIndex('PurchaseUnitMeasureId')
   ,CreateIndex('SalesUnitMeasureId')
  ]);
end;

procedure CreateCatalogProductTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogProductTable);
end;

end.
