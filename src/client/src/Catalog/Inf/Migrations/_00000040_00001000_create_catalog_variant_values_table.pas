unit _00000040_00001000_create_catalog_variant_values_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogVariantValueTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'variant_values';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogVariantValueTable }

procedure CreateCatalogVariantValueTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,GuidColumn('VariantId').IsRequired
   ,GuidColumn('ColumnId').IsRequired
   ,StringColumn('Value').HasMaxLength(255).IsUnicode.IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('VariantId', 'variants', 'Id')
   ,ForeignKey('ColumnId', 'columns', 'Id')
   ,Unique(['VariantId', 'ColumnId'])
  ])
  .Indexes([
    CreateIndex('ColumnId')
  ]);
end;

procedure CreateCatalogVariantValueTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogVariantValueTable);
end;

end.
