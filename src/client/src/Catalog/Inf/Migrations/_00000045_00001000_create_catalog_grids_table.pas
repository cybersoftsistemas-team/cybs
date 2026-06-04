unit _00000045_00001000_create_catalog_grids_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogGridsTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'grids';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogGridsTable }

procedure CreateCatalogGridsTable.Up(const ASchema: IMigrationBuilder);
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

procedure CreateCatalogGridsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogGridsTable);
end;

end.
