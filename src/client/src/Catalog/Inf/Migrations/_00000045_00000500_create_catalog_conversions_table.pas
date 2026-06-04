unit _00000045_00000500_create_catalog_conversions_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogConversionTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'conversions';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogConversionTable }

procedure CreateCatalogConversionTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,GuidColumn('ProductId').IsRequired
   ,GuidColumn('UnitMeasureId').IsRequired
   ,DecimalColumn('ConversionFactor').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,BooleanColumn('IsPurchaseDefault').HasDefaultValueSql('0').IsRequired
   ,BooleanColumn('IsSalesDefault').HasDefaultValueSql('0').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('ProductId', 'products', 'Id')
   ,ForeignKey('UnitMeasureId', 'unit_measures', 'Id')
   ,Unique(['ProductId', 'UnitMeasureId'])
  ])
  .Indexes([
    CreateIndex('ProductId')
   ,CreateIndex('UnitMeasureId')
   ,CreateIndex('ProductId')
    .IsUnique
    .HasFilterColumn('IsPurchaseDefault')
    .HasFilter('IsPurchaseDefault = 1')
   ,CreateIndex('ProductId')
    .IsUnique
    .HasFilterColumn('IsSalesDefault')
    .HasFilter('IsSalesDefault = 1')
  ]);
end;

procedure CreateCatalogConversionTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogConversionTable);
end;

end.
