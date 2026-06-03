unit _00000045_00000300_create_catalog_products_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogProductTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'products';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogProductTable }

procedure CreateCatalogProductTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,GuidColumn('NcmId').IsRequired
   ,BooleanColumn('LotControlled').HasDefaultValueSql('0').IsRequired
   ,BooleanColumn('ExpirationControlled').HasDefaultValueSql('0').IsRequired
   ,BooleanColumn('StockControlled').HasDefaultValueSql('1').IsRequired
   ,GuidColumn('ManufacturerId').IsOptional
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('Id', 'items', 'Id')
   ,ForeignKey('ManufacturerId', 'manufacturers', 'Id').HasPrincipalSchema('crm')
   ,ForeignKey('NcmId', 'ncms', 'Id').HasPrincipalSchema('fiscal')
  ])
  .Indexes([
    CreateIndex('ManufacturerId')
   ,CreateIndex('NcmId')
   ,CreateIndex(['ManufacturerId', 'StockControlled'])
   ,CreateIndex(['LotControlled', 'ExpirationControlled'])
  ]);
end;

procedure CreateCatalogProductTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogProductTable);
end;

end.
