unit _2025_12_09_00000055_create_person_nationalities_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonNationalitiesTable = class(TMigration)
  private
    const TableName = 'nationalities';
    const SchemaName = 'person';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePersonNationalitiesTable }

procedure CreatePersonNationalitiesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,GuidColumn('CountryId')
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CountryId', 'countries', 'Id').HasPrincipalSchema('address')
    ,Unique(['CountryId', 'Name'])
   ]);
end;

procedure CreatePersonNationalitiesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
