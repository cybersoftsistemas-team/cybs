unit _2025_12_08_00000070_create_people_person_naturals_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeoplePersonNaturalsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeoplePersonNaturalsTable }

procedure CreatePeoplePersonNaturalsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('person_naturals')
   .HasSchema('people')
   .Columns([
     GuidColumn('Id').IsRequired
    ,StringColumn('FirstName').HasMaxLength(127).IsRequired
    ,StringColumn('LastName').HasMaxLength(127).IsOptional
    ,DateTimeColumn('Birthday').IsOptional
    ,IntColumn('SSN').IsRequired // SSN – Social Security Number (CPF)
    ,StringColumn('IDCard').HasMaxLength(15).IsOptional // ID Card (RG)
    ,GuidColumn('PlaceOfBirthId').IsOptional // Naturalidade
    ,GuidColumn('NationalityId').IsOptional // Nacionalidade
    ,GuidColumn('GenderId').IsOptional // Gênero
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('GenderId', 'categories', 'Id').HasPrincipalSchema('auxiliary_data')
    ,ForeignKey('NationalityId', 'nationalities', 'Id')
    ,ForeignKey('persons', 'Id')
    ,ForeignKey('PlaceOfBirthId', 'cities', 'Id').HasPrincipalSchema('address')
    ,Unique('SSN')
   ])
   .Indexes([
     CreateIndex('GenderId')
    ,CreateIndex('NationalityId')
    ,CreateIndex('PlaceOfBirthId')
   ]);
end;

procedure CreatePeoplePersonNaturalsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('person_naturals')
   .HasSchema('people');
end;

end.
