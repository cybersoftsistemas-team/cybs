unit _00000045_00000200_create_catalog_unit_measures_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogUnitMeasureTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'unit_measures';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogUnitMeasureTable }

procedure CreateCatalogUnitMeasureTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Code').HasMaxLength(50).IsUnicode.IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
   ,StringColumn('Symbol').HasMaxLength(20).IsUnicode.IsRequired
   ,GuidColumn('MeasureTypeId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('MeasureTypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ,Unique('Code')
  ])
  .Indexes([
    CreateIndex('MeasureTypeId')
   ,CreateIndex('Name')
   ,CreateIndex('Symbol')
  ]);
end;

procedure CreateCatalogUnitMeasureTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogUnitMeasureTable);
end;

end.
