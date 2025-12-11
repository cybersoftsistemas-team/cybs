unit _2025_12_08_00000075_create_people_person_emails_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeoplePersonEmailsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeoplePersonEmailsTable }

procedure CreatePeoplePersonEmailsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('person_emails')
   .HasSchema('people')
   .Columns([
     GuidColumn('PersonId').IsRequired
    ,GuidColumn('TypeId').IsRequired
    ,StringColumn('Address').HasMaxLength(255).IsRequired
   ])
   .Constraints([
     PrimaryKey(['PersonId', 'TypeId'])
    ,ForeignKey('PersonId', 'persons', 'Id')
    ,ForeignKey('TypeId', 'categories', 'Id').HasPrincipalSchema('auxiliary_data')
   ]);
end;

procedure CreatePeoplePersonEmailsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('person_emails')
   .HasSchema('people');
end;

end.
