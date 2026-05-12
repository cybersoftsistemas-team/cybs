unit _00000050_00000300_create_country_nationalities_table;

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

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCountryNationalitiesTable }

procedure CreateCountryNationalitiesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('Id', 'countries', 'Id')
   ,Unique('Name')
  ]);
end;

procedure CreateCountryNationalitiesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCountryNationalitiesTable);
end;

end.
