unit _2025_12_08_00000060_create_person_persons_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonPersonsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePersonPersonsTable }

procedure CreatePersonPersonsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('persons')
   .HasSchema('person')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,GuidColumn('PersonTypeId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('PersonTypeId', 'categories', 'Id').HasPrincipalSchema('auxiliary_data')
   ])
   .Indexes([
     CreateIndex('PersonTypeId')
   ]);
end;

procedure CreatePersonPersonsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('persons')
   .HasSchema('person');
end;

end.
