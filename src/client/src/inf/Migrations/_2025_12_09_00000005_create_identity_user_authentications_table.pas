unit _2025_12_09_00000005_create_identity_user_authentications_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityUserAuthenticationsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentityUserAuthenticationsTable }

procedure CreateIdentityUserAuthenticationsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('user_authentications')
   .HasSchema('identity')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,BooleanColumn('AccountBlockedOut').HasDefaultValueSql('0').IsRequired
    ,DateTimeColumn('AccountExpiresDate').IsOptional
    ,StringColumn('Password').HasMaxLength(255).IsRequired
    ,GuidColumn('PersonId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('PersonId', 'naturals', 'Id').HasPrincipalSchema('person')
    ,Unique('Name')
   ]);
end;

procedure CreateIdentityUserAuthenticationsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('user_authentications')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentityUserAuthenticationsTable);
end;

end.
