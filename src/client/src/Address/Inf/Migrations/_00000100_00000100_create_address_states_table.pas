unit _00000100_00000100_create_address_states_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressStatesTable = class(TMigration)
  private
    const TableName = 'states';
    const SchemaName = 'address';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateAddressStatesTable }

procedure CreateAddressStatesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
   ,StringColumn('Acronym').HasMaxLength(10).IsUnicode.IsOptional
   ,GuidColumn('CountryId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('CountryId', 'countries', 'Id').HasPrincipalSchema('country')
   ,Unique(['CountryId', 'Acronym'])
   ,Unique(['CountryId', 'Name'])
  ])
  .Indexes([
    CreateIndex('CountryId')
  ]);

  ASchema.AddDefault('Id', 'NEWSEQUENTIALID()')
  .HasTable(TableName)
  .HasSchema(SchemaName);
end;

procedure CreateAddressStatesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateAddressStatesTable);
end;

end.

