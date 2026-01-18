unit _00000001_00002100_create_person_phones_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonPhonesTable = class(TMigration)
  private
    const TableName = 'phones';
    const SchemaName = 'person';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePersonPhonesTable }

procedure CreatePersonPhonesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('PersonId').IsRequired
    ,GuidColumn('TypeId').IsRequired
    ,IntColumn('Number').HasDefaultValueSql('0').IsRequired
    ,GuidColumn('CityId').IsRequired
   ])
   .Constraints([
     PrimaryKey(['PersonId', 'TypeId'])
    ,ForeignKey('CityId', 'cities', 'Id').HasPrincipalSchema('address')
    ,ForeignKey('PersonId', 'persons', 'Id')
    ,ForeignKey('TypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ])
   .Indexes([
     CreateIndex('CityId')
    ,CreateIndex('PersonId')
    ,CreateIndex('TypeId')
   ]);
end;

procedure CreatePersonPhonesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
