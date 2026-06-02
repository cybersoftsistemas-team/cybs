unit _00000040_00000500_create_catalog_grids_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogGridTable = class(TMigration)
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

{ CreateCatalogGridTable }

procedure CreateCatalogGridTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,BooleanColumn('StockControlled').HasDefaultValueSql('0').IsRequired
   ,GuidColumn('ProductId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('ProductId', 'products', 'Id').HasPrincipalSchema('catalog')
   ,Unique('ProductId')
  ]);
end;

procedure CreateCatalogGridTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogGridTable);
end;

end.
