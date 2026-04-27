unit _00001000_00000005_create_identity_configs_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityConfigsTable = class(TMigration)
  private
    const TableName = 'configs';
    const SchemaName = 'identity';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateIdentityConfigsTable }

procedure CreateIdentityConfigsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    IntColumn('Id').HasDefaultValueSql('1').IsRequired
   ,IntColumn('MaxAttempts').HasDefaultValueSql('5').IsRequired
   ,IntColumn('LockoutMinutes').HasDefaultValueSql('15').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,CheckConstraint(Concat(SchemaName, '_', TableName, '_singleton_check'), '(Id = 1)')
  ]);
end;

procedure CreateIdentityConfigsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityConfigsTable);
end;

end.
