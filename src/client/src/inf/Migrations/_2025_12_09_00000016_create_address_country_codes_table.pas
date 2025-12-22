unit _2025_12_09_00000016_create_address_country_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressCountryCodesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressCountryCodesTable }

procedure CreateAddressCountryCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('country_codes')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('CodeType').HasMaxLength(50).IsRequired
    ,StringColumn('Code').HasMaxLength(10).IsRequired
    ,GuidColumn('CountryId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CountryId', 'countries', 'Id')
    ,Unique(['CodeType', 'Code'])
   ]);
end;

procedure CreateAddressCountryCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('country_codes')
   .HasSchema('address');
end;

end.
