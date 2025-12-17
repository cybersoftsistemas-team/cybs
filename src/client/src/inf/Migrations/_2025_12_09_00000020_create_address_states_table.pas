unit _2025_12_09_00000020_create_address_states_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressStatesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressStatesTable }

procedure CreateAddressStatesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('states')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,StringColumn('Acronym').HasMaxLength(10).IsOptional
    ,GuidColumn('CountryId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('CountryId', 'countries', 'Id')
    ,Unique(['CountryId', 'Name'])
   ]);
end;

procedure CreateAddressStatesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('states')
   .HasSchema('address');
end;

end.
