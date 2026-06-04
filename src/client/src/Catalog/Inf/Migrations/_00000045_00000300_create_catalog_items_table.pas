unit _00000045_00000300_create_catalog_items_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogItemsTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'items';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogItemsTable }

procedure CreateCatalogItemsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Code').HasMaxLength(50).IsUnicode.IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
   ,StringColumn('Description').IsMaxLength.IsUnicode.IsRequired
   ,BooleanColumn('Active').HasDefaultValueSql('1').IsRequired
   ,DecimalColumn('CostPrice').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,DecimalColumn('SalePrice').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,DateTimeColumn('CreatedAt').HasDefaultValueSql('GETDATE()').IsRequired
   ,DateTimeColumn('UpdatedAt').IsOptional
   ,GuidColumn('ItemTypeId').IsRequired
   ,GuidColumn('UnitMeasureId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('ItemTypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ,ForeignKey('UnitMeasureId', 'unit_measures', 'Id')
   ,Unique('Code')
  ])
  .Indexes([
    CreateIndex('Name')
   ,CreateIndex('ItemTypeId')
   ,CreateIndex('UnitMeasureId')
   ,CreateIndex(['ItemTypeId', 'Active'])
   ,CreateIndex(['UnitMeasureId', 'Active'])
  ]);
end;

procedure CreateCatalogItemsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogItemsTable);
end;

end.
