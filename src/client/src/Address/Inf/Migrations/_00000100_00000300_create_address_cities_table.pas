unit _00000100_00000300_create_address_cities_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressCitiesTable = class(TMigration)
  private
    const TableName = 'cities';
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateAddressCitiesTable }

procedure CreateAddressCitiesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
   ,GuidColumn('AreaCodeId').IsOptional
   ,GuidColumn('StateId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('StateId', 'states', 'Id')
   ,Unique(['StateId', 'Name'])
  ])
  .Indexes([
    CreateIndex('AreaCodeId')
   ,CreateIndex('StateId')
  ]);
end;

procedure CreateAddressCitiesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateAddressCitiesTable);
end;

end.
