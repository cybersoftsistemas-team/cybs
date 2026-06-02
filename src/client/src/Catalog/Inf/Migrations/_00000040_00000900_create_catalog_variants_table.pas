unit _00000040_00000900_create_catalog_variants_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogVariantTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'variants';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogVariantTable }

procedure CreateCatalogVariantTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('SKU').HasMaxLength(100).IsUnicode.IsRequired
   ,StringColumn('Gtin').HasMaxLength(14).IsUnicode.IsOptional
   ,BooleanColumn('Active').HasDefaultValueSql('1').IsRequired
   ,GuidColumn('GridId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('GridId', 'grids', 'Id')
   ,Unique('SKU')
  ])
  .Indexes([
    CreateIndex('GridId')
  ]);
end;

procedure CreateCatalogVariantTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogVariantTable);
end;

end.
