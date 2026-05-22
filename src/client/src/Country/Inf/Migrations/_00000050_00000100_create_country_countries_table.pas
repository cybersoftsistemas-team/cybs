unit _00000050_00000100_create_country_countries_table;

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

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCountryCountriesTable }

procedure CreateCountryCountriesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
   ,StringColumn('DialCode').HasMaxLength(10).IsUnicode.IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,Unique('DialCode')
   ,Unique('Name')
  ]);

  ASchema.AddDefault('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');
end;

procedure CreateCountryCountriesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCountryCountriesTable);
end;

end.
