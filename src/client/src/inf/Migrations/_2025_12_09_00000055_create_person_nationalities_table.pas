unit _2025_12_09_00000055_create_person_nationalities_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonNationalitiesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreatePersonNationalitiesTable }

procedure CreatePersonNationalitiesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('nationalities')
   .HasSchema('person')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,GuidColumn('CountryId')
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CountryId', 'countries', 'Id').HasPrincipalSchema('address')
    ,Unique(['CountryId', 'Name'])
   ]);
end;

procedure CreatePersonNationalitiesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('nationalities')
   .HasSchema('person');
end;

initialization
begin
  RegisterMigration(TDbContext, CreatePersonNationalitiesTable);
end;

end.
