unit _2025_12_09_00000035_create_address_streets_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressStreetsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressStreetsTable }

procedure CreateAddressStreetsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('streets')
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

procedure CreateAddressStreetsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('streets')
   .HasSchema('address');
end;

end.
