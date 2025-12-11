unit _2025_12_08_00000060_create_people_persons_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePeoplePersonsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePeoplePersonsTable }

procedure CreatePeoplePersonsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('persons')
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

procedure CreatePeoplePersonsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('persons')
   .HasSchema('people');
end;

end.
