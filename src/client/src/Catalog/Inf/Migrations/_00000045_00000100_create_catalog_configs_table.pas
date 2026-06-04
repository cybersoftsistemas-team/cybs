unit _00000045_00000100_create_catalog_configs_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCatalogConfigsTable = class(TMigration)
  private
    const SchemaName = 'catalog';
    const TableName  = 'configs';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCatalogConfigsTable }

procedure CreateCatalogConfigsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    IntColumn('Id')
    .HasDefaultValueSql('1')
    .IsRequired()
   ,StringColumn('ProductCodePattern')
    .HasDefaultValueSql('''PRD{00000000}''')
    .HasMaxLength(30)
    .IsUnicode
    .IsRequired()
   ,StringColumn('ServiceCodePattern')
    .HasDefaultValueSql('''SRV{00000000}''')
    .HasMaxLength(30)
    .IsUnicode
    .IsRequired()
  ])
  .Constraints([
    PrimaryKey('Id')
   ,CheckConstraint(Format('%s_%s_singleton_check', [SchemaName, TableName]), '(Id = 1)')
  ]);
end;

procedure CreateCatalogConfigsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCatalogConfigsTable);
end;

end.
