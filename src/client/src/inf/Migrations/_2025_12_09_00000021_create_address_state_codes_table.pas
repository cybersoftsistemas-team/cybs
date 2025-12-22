unit _2025_12_09_00000021_create_address_state_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressStateCodesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAddressStateCodesTable }

procedure CreateAddressStateCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('state_codes')
   .HasSchema('address')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('CodeType').HasMaxLength(50).IsRequired
    ,StringColumn('Code').HasMaxLength(10).IsRequired
    ,GuidColumn('StateId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('StateId', 'states', 'Id')
    ,Unique(['CodeType', 'Code'])
   ])
   .Indexes([
     CreateIndex('StateId')
   ]);
end;

procedure CreateAddressStateCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('state_codes')
   .HasSchema('address');
end;

end.
