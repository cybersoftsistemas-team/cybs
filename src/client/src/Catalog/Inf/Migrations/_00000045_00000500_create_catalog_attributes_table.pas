unit _00000045_00000500_create_catalog_attributes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogAttributeTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'attributes';
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
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,Unique('Name')
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
