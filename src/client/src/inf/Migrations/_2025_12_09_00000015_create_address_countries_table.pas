unit _2025_12_09_00000015_create_address_countries_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressCountriesTable = class(TMigration)
  private
    const TableName = 'countries';
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressCountriesTable }

procedure CreateAddressCountriesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,IntColumn('AreaCode').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,Unique('AreaCode')
    ,Unique('Name')
   ]);
end;

procedure CreateAddressCountriesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
