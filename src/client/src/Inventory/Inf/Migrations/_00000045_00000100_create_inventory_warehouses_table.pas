unit _00000045_00000100_create_inventory_warehouses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateInventoryWarehousesTable = class(TMigration)
  private
    const SchemaName = 'inventory';
    const TableName  = 'warehouses';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateInventoryWarehousesTable }

procedure CreateInventoryWarehousesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Code').HasMaxLength(50).IsUnicode.IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
   ,BooleanColumn('Active').HasDefaultValueSql('1').IsRequired
   ,GuidColumn('DomainId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('DomainId', 'domains', 'Id').HasPrincipalSchema('domain')
   ,Unique(['DomainId', 'Code'])
  ])
  .Indexes([
    CreateIndex('DomainId')
  ]);
end;

procedure CreateInventoryWarehousesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateInventoryWarehousesTable);
end;

end.
