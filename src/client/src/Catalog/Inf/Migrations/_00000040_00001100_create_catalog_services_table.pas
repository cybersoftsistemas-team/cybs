unit _00000040_00001100_create_catalog_services_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogServiceTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'services';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogServiceTable }

procedure CreateCatalogServiceTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('Id', 'items', 'Id')
  ]);
end;

procedure CreateCatalogServiceTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogServiceTable);
end;

end.
