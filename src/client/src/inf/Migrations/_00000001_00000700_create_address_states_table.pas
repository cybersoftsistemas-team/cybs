unit _00000001_00000700_create_address_states_table;

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

{ CreateAddressStatesTable }

procedure CreateAddressStatesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,StringColumn('Acronym').HasMaxLength(10).IsOptional
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
end;

procedure CreateAddressStatesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
