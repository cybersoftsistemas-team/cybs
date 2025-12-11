unit _2025_12_09_00000015_create_identity_user_authentication_options_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityUserAuthenticationOptionsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentityUserAuthenticationOptionsTable }

procedure CreateIdentityUserAuthenticationOptionsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('user_authentication_options')
   .HasSchema('identity')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,StringColumn('Description').HasColumnType('ntext').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,Unique('Name')
   ]);
end;

procedure CreateIdentityUserAuthenticationOptionsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('user_authentication_options')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentityUserAuthenticationOptionsTable);
end;

end.
