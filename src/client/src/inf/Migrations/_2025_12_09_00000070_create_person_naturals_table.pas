unit _2025_12_09_00000070_create_person_naturals_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonNaturalsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreatePersonNaturalsTable }

procedure CreatePersonNaturalsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('naturals')
   .HasSchema('person')
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
    ,ForeignKey('GenderId', 'categories', 'Id').HasPrincipalSchema('general')
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

procedure CreatePersonNaturalsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('naturals')
   .HasSchema('person');
end;

initialization
begin
  RegisterMigration(TDbContext, CreatePersonNaturalsTable);
end;

end.
