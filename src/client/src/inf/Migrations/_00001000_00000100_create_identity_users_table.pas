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
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,StringColumn('Description').IsRequired
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
   ])
   .Indexes([
     CreateIndex('PersonId')
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
