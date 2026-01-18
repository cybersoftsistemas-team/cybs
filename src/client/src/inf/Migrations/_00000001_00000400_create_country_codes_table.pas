unit _00000001_00000400_create_country_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCountryCodesTable = class(TMigration)
  private
    const TableName = 'codes';
    const SchemaName = 'country';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateCountryCodesTable }

procedure CreateCountryCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     StringColumn('CodeType').HasMaxLength(50).IsRequired
    ,StringColumn('Code').HasMaxLength(10).IsRequired
    ,GuidColumn('CountryId').IsRequired
   ])
   .Constraints([
     PrimaryKey(['CodeType', 'Code'])
    ,ForeignKey('CountryId', 'countries', 'Id')
   ])
   .Indexes([
     CreateIndex('CountryId')
   ]);
end;

procedure CreateCountryCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
