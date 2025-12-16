unit _2025_12_09_00000060_create_person_persons_table;

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

uses
{PROJECT}
  cbsMain.inf.DbContext;

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
    ,ForeignKey('PersonTypeId', 'categories', 'Id').HasPrincipalSchema('general')
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

initialization
begin
  RegisterMigration(TDbContext, CreatePersonPersonsTable);
end;

end.

