unit _2025_12_09_00000005_create_identity_users_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityUsersTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentityUsersTable }

procedure CreateIdentityUsersTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('users')
   .HasSchema('identity')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,StringColumn('Description').HasColumnType('ntext').IsRequired
    ,BooleanColumn('AccountBlockedOut').HasDefaultValueSql('0').IsRequired
    ,DateTimeColumn('AccountExpiresDate').IsOptional
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
    ,StringColumn('Password').HasMaxLength(255).IsRequired
    ,GuidColumn('PersonId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('PersonId', 'naturals', 'Id').HasPrincipalSchema('person')
    ,Unique('Name')
   ]);
end;

procedure CreateIdentityUsersTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('users')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentityUsersTable);
end;

end.
