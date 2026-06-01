unit _00000010_00000600_create_address_streets_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressStreetsTable = class(TMigration)
  private
    const SchemaName = 'address';
    const TableName  = 'streets';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateAddressStreetsTable }

procedure CreateAddressStreetsTable.Up(const ASchema: IMigrationBuilder);
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

procedure CreateAddressStreetsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateAddressStreetsTable);
end;

end.
