unit _00000010_00000200_create_address_state_codes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAddressStateCodesTable = class(TMigration)
  private
    const SchemaName = 'address';
    const TableName  = 'state_codes';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateAddressStateCodesTable }

procedure CreateAddressStateCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('CodeType').HasMaxLength(50).IsUnicode.IsRequired
   ,StringColumn('Code').HasMaxLength(10).IsUnicode.IsRequired
   ,GuidColumn('StateId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('StateId', 'states', 'Id')
   ,Unique(['CodeType', 'Code'])
  ])
  .Indexes([
    CreateIndex(['CodeType', 'StateId'])
   ,CreateIndex('StateId')
  ]);
end;

procedure CreateAddressStateCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateAddressStateCodesTable);
end;

end.
