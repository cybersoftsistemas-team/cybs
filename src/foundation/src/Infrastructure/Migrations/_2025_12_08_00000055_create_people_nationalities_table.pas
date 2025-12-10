unit _2025_12_08_00000055_create_people_nationalities_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeopleNationalitiesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeopleNationalitiesTable }

procedure CreatePeopleNationalitiesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('nationalities')
   .HasSchema('people')
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

procedure CreatePeopleNationalitiesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('nationalities')
   .HasSchema('people');
end;

end.
