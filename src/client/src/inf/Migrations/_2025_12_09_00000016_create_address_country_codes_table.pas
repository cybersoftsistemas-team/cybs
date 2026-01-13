unit _2025_12_09_00000016_create_address_country_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressCountryCodesTable = class(TMigration)
  private
    const TableName = 'country_codes';
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressCountryCodesTable }

procedure CreateAddressCountryCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
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
   ])
   .Indexes([
     CreateIndex('CountryId')
   ]);
end;

procedure CreateAddressCountryCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
