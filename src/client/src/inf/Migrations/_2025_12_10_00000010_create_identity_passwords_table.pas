unit _2025_12_10_00000010_create_identity_passwords_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityPasswordsTable = class(TMigration)
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
  ASchema.CreateTable('passwords')
   .HasSchema('identity')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Password').HasMaxLength(255).IsRequired
    ,GuidColumn('UserId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('UserId', 'users', 'Id')
    ,Unique(['UserId', 'Password'])
   ]);
end;

procedure CreateIdentityPasswordsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('passwords')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityPasswordsTable);
end;

end.
