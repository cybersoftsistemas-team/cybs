unit _2025_12_09_00000015_create_address_countries_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressCountriesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressCountriesTable }

procedure CreateAddressCountriesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('countries')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,IntColumn('AreaCode').HasDefaultValueSql('0').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,Unique('Name')
   ])
   .Indexes([
     CreateIndex('AreaCode')
   ]);
end;

procedure CreateAddressCountriesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('countries')
   .HasSchema('address');
end;

end.
