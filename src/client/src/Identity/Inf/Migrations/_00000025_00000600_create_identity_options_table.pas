unit _00000025_00000600_create_identity_options_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityOptionsTable = class(TMigration)
  private
    const SchemaName = 'identity';
    const TableName  = 'options';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateIdentityOptionsTable }

procedure CreateIdentityOptionsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
   ,StringColumn('Description').IsMaxLength.IsUnicode.IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,Unique('Name')
  ]);
end;

procedure CreateIdentityOptionsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityOptionsTable);
end;

end.
