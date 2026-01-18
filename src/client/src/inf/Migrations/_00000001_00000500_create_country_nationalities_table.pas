unit _00000001_00000500_create_country_nationalities_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCountryNationalitiesTable = class(TMigration)
  private
    const TableName = 'nationalities';
    const SchemaName = 'country';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateCountryNationalitiesTable }

procedure CreateCountryNationalitiesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,GuidColumn('CountryId')
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CountryId', 'countries', 'Id')
    ,Unique('Name')
   ])
   .Indexes([
     CreateIndex('CountryId')
   ]);
end;

procedure CreateCountryNationalitiesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
