unit _00000045_00000700_create_catalog_columns_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogColumnTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'columns';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogColumnTable }

procedure CreateCatalogColumnTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,IntColumn('Order').IsRequired
   ,GuidColumn('AttributeId').IsRequired
   ,GuidColumn('DataTypeId').IsRequired
   ,GuidColumn('ProductId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('AttributeId', 'attributes', 'Id')
   ,ForeignKey('DataTypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ,ForeignKey('ProductId', 'products', 'Id')
   ,Unique(['ProductId', 'AttributeId'])
   ,Unique(['ProductId', 'Order'])
  ])
  .Indexes([
    CreateIndex('AttributeId')
   ,CreateIndex('DataTypeId')
   ,CreateIndex('ProductId')
  ]);
end;

procedure CreateCatalogColumnTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogColumnTable);
end;

end.
