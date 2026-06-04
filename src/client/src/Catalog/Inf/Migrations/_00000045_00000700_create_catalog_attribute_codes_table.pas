unit _00000045_00000700_create_catalog_attribute_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogAttributeTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'attribute_codes';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogAttributeTable }

procedure CreateCatalogAttributeTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Code').HasMaxLength(100).IsUnicode.IsRequired
   ,StringColumn('CodeType').HasMaxLength(50).IsUnicode.IsRequired
   ,GuidColumn('AttributeId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('AttributeId', 'attributes', 'Id')
   ,Unique(['AttributeId', 'CodeType'])
   ,Unique(['CodeType', 'Code'])
  ]);
end;

procedure CreateCatalogAttributeTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogAttributeTable);
end;

end.
