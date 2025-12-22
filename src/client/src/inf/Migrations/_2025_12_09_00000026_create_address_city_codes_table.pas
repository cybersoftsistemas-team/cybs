unit _2025_12_09_00000026_create_address_city_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressCityCodesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressCityCodesTable }

procedure CreateAddressCityCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('city_codes')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('CodeType').HasMaxLength(50).IsRequired
    ,StringColumn('Code').HasMaxLength(10).IsRequired
    ,GuidColumn('CityId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CityId', 'cities', 'Id')
    ,Unique(['CodeType', 'Code'])
   ])
   .Indexes([
     CreateIndex('CityId')
   ]);
end;

procedure CreateAddressCityCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('city_codes')
   .HasSchema('address');
end;

end.
