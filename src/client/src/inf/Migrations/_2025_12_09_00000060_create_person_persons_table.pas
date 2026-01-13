unit _2025_12_09_00000060_create_person_persons_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonPersonsTable = class(TMigration)
  private
    const TableName = 'persons';
    const SchemaName = 'person';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePersonPersonsTable }

procedure CreatePersonPersonsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
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
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.

