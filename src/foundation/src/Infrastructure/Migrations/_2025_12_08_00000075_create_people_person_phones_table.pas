unit _2025_12_08_00000075_create_people_person_phones_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeoplePersonPhonesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeoplePersonPhonesTable }

procedure CreatePeoplePersonPhonesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('person_phones')
   .HasSchema('people')
   .Columns([
     GuidColumn('PersonId').IsRequired
    ,GuidColumn('TypeId').IsRequired
    ,GuidColumn('CityId').IsRequired
    ,IntColumn('Number').HasDefaultValueSql('0').IsRequired
   ])
   .Constraints([
     PrimaryKey(['PersonId', 'TypeId'])
    ,ForeignKey('CityId', 'cities', 'Id').HasPrincipalSchema('address')
    ,ForeignKey('PersonId', 'persons', 'Id')
    ,ForeignKey('TypeId', 'categories', 'Id').HasPrincipalSchema('auxiliary_data')
   ]);
end;

procedure CreatePeoplePersonPhonesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('person_phones')
   .HasSchema('people');
end;

end.
