unit _2025_12_09_00000085_create_person_phones_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonPhonesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePersonPhonesTable }

procedure CreatePersonPhonesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('phones')
   .HasSchema('person')
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
   ]);
end;

procedure CreatePersonPhonesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('phones')
   .HasSchema('person');
end;

end.
