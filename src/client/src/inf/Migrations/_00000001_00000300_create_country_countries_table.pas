unit _00000001_00000300_create_country_countries_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCountryCountriesTable = class(TMigration)
  private
    const TableName = 'countries';
    const SchemaName = 'country';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateCountryCountriesTable }

procedure CreateCountryCountriesTable.Up(const ASchema: IMigrationBuilder);
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

procedure CreateCountryCountriesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
