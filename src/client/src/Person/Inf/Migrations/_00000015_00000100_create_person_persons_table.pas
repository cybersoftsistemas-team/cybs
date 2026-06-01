unit _00000015_00000100_create_person_persons_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonPersonsTable = class(TMigration)
  private
    const SchemaName = 'person';
    const TableName  = 'persons';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreatePersonPersonsTable }

procedure CreatePersonPersonsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
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
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreatePersonPersonsTable);
end;

end.

