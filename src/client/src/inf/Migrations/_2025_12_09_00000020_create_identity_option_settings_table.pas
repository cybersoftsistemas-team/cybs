unit _2025_12_09_00000020_create_identity_option_settings_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityOptionSettingsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentityOptionSettingsTable }

procedure CreateIdentityOptionSettingsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('option_settings')
   .HasSchema('identity')
   .Columns([
     GuidColumn('UserId').IsRequired
    ,GuidColumn('UserOptionId').IsRequired
    ,BooleanColumn('Checked').HasDefaultValueSql('0').IsRequired
   ])
   .Constraints([
     PrimaryKey(['UserId', 'UserOptionId'])
    ,ForeignKey('UserId', 'user_authentications', 'Id')
    ,ForeignKey('UserOptionId', 'user_authentication_options', 'Id')
   ]);
end;

procedure CreateIdentityOptionSettingsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('option_settings')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentityOptionSettingsTable);
end;

end.
