unit _00001000_00000100_create_identity_users_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityUsersTable = class(TMigration)
  private
    const TableName = 'users';
    const SchemaName = 'identity';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateIdentityUsersTable }

procedure CreateIdentityUsersTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
    ,StringColumn('Description').IsUnicode.IsRequired
    ,IntColumn('AccessFailedCount').HasDefaultValueSql('0').IsRequired
    ,ComputedColumn('AccountActivated')
     .HasSqlAs(
      'CASE ' +
      '    WHEN LockoutEnd IS NOT NULL AND LockoutEnd > GETDATE() THEN CAST(0 AS BIT) ' +
      '    WHEN AccountExpiresDate IS NOT NULL AND AccountExpiresDate < GETDATE() THEN CAST(0 AS BIT) ' +
      '    ELSE CAST(1 AS BIT) ' +
      'END')
     .IsOptional
    ,ComputedColumn('AccountBlockedOut')
     .HasSqlAs(
      'CASE ' +
      '    WHEN LockoutEnd IS NOT NULL AND LockoutEnd > GETDATE() THEN CAST(1 AS BIT) ' +
      '    ELSE CAST(0 AS BIT) ' +
      'END')
     .IsOptional
    ,ComputedColumn('AccountExpired')
     .HasSqlAs(
      'CASE ' +
      '    WHEN [AccountExpiresDate] IS NULL THEN CONVERT(bit, 0) ' +
      '    WHEN [AccountExpiresDate] < GETDATE() THEN CONVERT(bit, 1) ' +
      '    ELSE CONVERT(bit, 0) ' +
      'END')
     .IsOptional
    ,DateTimeColumn('AccountExpiresDate').IsOptional
    ,DateTimeColumn('LastLoginAt').IsOptional
    ,DateTimeColumn('LockoutEnd').IsOptional
    ,StringColumn('PasswordHash').HasColumnType('VARBINARY(64)').IsRequired
    ,IntColumn('PasswordIterations').HasDefaultValueSql('100000').IsRequired
    ,StringColumn('PasswordSalt').HasColumnType('VARBINARY(32)').IsRequired
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
    ,GuidColumn('PersonId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('PersonId', 'naturals', 'Id').HasPrincipalSchema('person')
    ,Unique('Name')
   ])
   .Indexes([
     CreateIndex('AccountExpiresDate')
    ,CreateIndex('LockoutEnd')
    ,CreateIndex('PersonId')
   ]);
end;

procedure CreateIdentityUsersTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityUsersTable);
end;

end.

