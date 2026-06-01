unit _00000025_00000600_create_identity_passwords_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityPasswordsTable = class(TMigration)
  private
    const SchemaName = 'identity';
    const TableName  = 'passwords';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateIdentityPasswordsTable }

procedure CreateIdentityPasswordsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('UserId').IsRequired
   ,StringColumn('Hash').HasColumnType('VARBINARY(64)').IsRequired
   ,IntColumn('Iterations').HasDefaultValueSql('125000').IsRequired
   ,StringColumn('Salt').HasColumnType('VARBINARY(32)').IsRequired
  ])
  .Constraints([
    PrimaryKey('UserId')
   ,ForeignKey('UserId', 'users', 'Id')
  ]);
end;

procedure CreateIdentityPasswordsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityPasswordsTable);
end;

end.
