unit _2025_12_08_00000060_create_people_person_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeoplePersonTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeoplePersonTable }

procedure CreatePeoplePersonTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('person')
   .HasSchema('people')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,GuidColumn('PersonType').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('PersonType', 'categories', 'Id').HasPrincipalSchema('auxiliary_data')
   ])
   .Indexes([
     CreateIndex('PersonType')
   ]);
end;

procedure CreatePeoplePersonTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('person')
   .HasSchema('people');
end;

end.
