unit _00001000_00000200_create_identity_passwords_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityPasswordsTable = class(TMigration)
  private
    const TableName = 'passwords';
    const SchemaName = 'identity';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateIdentityPasswordsTable }

procedure CreateIdentityPasswordsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Password').HasMaxLength(255).IsRequired
    ,GuidColumn('UserId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('UserId', 'users', 'Id')
    ,Unique(['UserId', 'Password'])
   ])
   .Indexes([
     CreateIndex('UserId')
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
