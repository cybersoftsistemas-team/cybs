unit _2025_12_08_00000065_create_people_person_legals_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeoplePersonLegalsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeoplePersonLegalsTable }

procedure CreatePeoplePersonLegalsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('person_legals')
   .HasSchema('people')
   .Columns([
     GuidColumn('Id').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,StringColumn('DoingBusinessAs').HasMaxLength(255).IsRequired // Nome fantasia
    ,IntColumn('CRN').IsOptional // CRN – Company Registration Number (CNPJ)
    ,DateTimeColumn('FoundationDate').IsRequired
    ,StringColumn('StateInscriptionNumber').HasMaxLength(20).IsOptional // Inscrição Estadual
    ,StringColumn('MunicipalInscription').HasMaxLength(20).IsOptional // Inscrição Municipal
    ,GuidColumn('CompanyTypeId').IsRequired
    ,GuidColumn('NationalityId').IsRequired // Nacionalidade
    ,GuidColumn('StateId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CompanyTypeId', 'categories', 'Id').HasPrincipalSchema('auxiliary_data')
    ,ForeignKey('NationalityId', 'nationalities', 'Id')
    ,ForeignKey('persons', 'Id')
    ,ForeignKey('StateId', 'states', 'Id').HasPrincipalSchema('address')
    ,Unique('CRN')
   ])
   .Indexes([
     CreateIndex('CompanyTypeId')
    ,CreateIndex('NationalityId')
    ,CreateIndex('StateId')
   ]);
end;

procedure CreatePeoplePersonLegalsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('person_legals')
   .HasSchema('people');
end;

end.
