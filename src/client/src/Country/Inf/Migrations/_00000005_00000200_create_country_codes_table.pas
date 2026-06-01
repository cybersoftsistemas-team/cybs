unit _00000005_00000200_create_country_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCountryCodesTable = class(TMigration)
  private
    const SchemaName = 'country';
    const TableName  = 'codes';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCountryCodesTable }

procedure CreateCountryCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('CodeType').HasMaxLength(50).IsUnicode.IsRequired
   ,StringColumn('Code').HasMaxLength(10).IsUnicode.IsRequired
   ,GuidColumn('CountryId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('CountryId', 'countries', 'Id')
   ,Unique(['CodeType', 'Code'])
  ])
  .Indexes([
    CreateIndex(['CodeType', 'CountryId'])
   ,CreateIndex('CountryId')
  ]);
end;

procedure CreateCountryCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCountryCodesTable);
end;

end.
