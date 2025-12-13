unit _2025_12_08_00000075_create_person_emails_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonEmailsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePersonEmailsTable }

procedure CreatePersonEmailsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('emails')
   .HasSchema('person')
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

procedure CreatePersonEmailsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('emails')
   .HasSchema('person');
end;

end.
