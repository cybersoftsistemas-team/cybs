unit _00000100_00000400_create_address_city_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressCityCodesTable = class(TMigration)
  private
    const TableName = 'city_codes';
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateAddressCityCodesTable }

procedure CreateAddressCityCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,StringColumn('CodeType').HasMaxLength(50).IsUnicode.IsRequired
   ,StringColumn('Code').HasMaxLength(10).IsUnicode.IsRequired
   ,GuidColumn('CityId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('CityId', 'cities', 'Id')
   ,Unique(['CodeType', 'Code'])
  ])
  .Indexes([
    CreateIndex(['CodeType', 'CityId'])
   ,CreateIndex('CityId')
  ]);

  ASchema.AddDefaultValue('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');
end;

procedure CreateAddressCityCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateAddressCityCodesTable);
end;

end.
