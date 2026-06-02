unit _00000045_00000400_create_inventory_reservations_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateInventoryReservationsTable = class(TMigration)
  private
    const SchemaName = 'inventory';
    const TableName  = 'reservations';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateInventoryReservationsTable }

procedure CreateInventoryReservationsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,GuidColumn('WarehouseId').IsRequired
   ,GuidColumn('VariantId').IsRequired
   ,DecimalColumn('Quantity').HasDefaultValueSql('0').HasPrecision(18,6).IsRequired
   ,DateTimeColumn('ReservationDate').HasDefaultValueSql('GETDATE()').IsRequired
   ,DateTimeColumn('ExpirationDate').IsOptional
   ,GuidColumn('ReferenceTypeId').IsRequired
   ,GuidColumn('ReferenceId').IsRequired
   ,GuidColumn('StatusId').IsRequired
   ,StringColumn('Notes').IsMaxLength.IsUnicode.IsOptional
   ,DateTimeColumn('CreatedAt').HasDefaultValueSql('GETDATE()').IsRequired
   ,StringColumn('CreatedBy').HasMaxLength(255).IsUnicode.IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('WarehouseId', 'warehouses', 'Id')
   ,ForeignKey('VariantId', 'variants', 'Id').HasPrincipalSchema('catalog')
   ,ForeignKey('ReferenceTypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ,ForeignKey('StatusId', 'categories', 'Id').HasPrincipalSchema('general')
  ])
  .Indexes([
    CreateIndex(['WarehouseId', 'VariantId', 'StatusId'])
   ,CreateIndex('ReferenceId')
   ,CreateIndex('StatusId')
   ,CreateIndex('ExpirationDate')
  ]);
end;

procedure CreateInventoryReservationsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateInventoryReservationsTable);
end;

end.
