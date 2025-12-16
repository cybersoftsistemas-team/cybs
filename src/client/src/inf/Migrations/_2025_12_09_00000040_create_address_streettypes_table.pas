unit _2025_12_09_00000040_create_address_streettypes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressStreetTypesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateAddressStreetTypesTable }

procedure CreateAddressStreetTypesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('streettypes')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,Unique('Name')
   ]);
end;

procedure CreateAddressStreetTypesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('streettypes')
   .HasSchema('address');
end;

initialization
begin
  RegisterMigration(TDbContext, CreateAddressStreetTypesTable);
end;

end.
