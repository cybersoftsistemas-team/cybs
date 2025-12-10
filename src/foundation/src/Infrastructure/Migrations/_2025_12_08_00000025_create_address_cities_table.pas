unit _2025_12_08_00000025_create_address_cities_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressCitiesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressCitiesTable }

procedure CreateAddressCitiesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('cities')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,IntColumn('AreaCode').IsRequired
    ,GuidColumn('StateId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('StateId', 'states', 'Id')
    ,Unique(['StateId', 'Name'])
   ]);
end;

procedure CreateAddressCitiesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('cities')
   .HasSchema('address');
end;

end.
