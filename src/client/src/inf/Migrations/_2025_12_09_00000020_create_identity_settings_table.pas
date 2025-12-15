unit _2025_12_09_00000020_create_identity_settings_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentitySettingsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentitySettingsTable }

procedure CreateIdentitySettingsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('settings')
   .HasSchema('identity')
   .Columns([
     GuidColumn('UserId').IsRequired
    ,GuidColumn('OptionId').IsRequired
    ,BooleanColumn('Checked').HasDefaultValueSql('0').IsRequired
   ])
   .Constraints([
     PrimaryKey(['UserId', 'OptionId'])
    ,ForeignKey('UserId', 'users', 'Id')
    ,ForeignKey('OptionId', 'options', 'Id')
   ]);
end;

procedure CreateIdentitySettingsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('settings')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentitySettingsTable);
end;

end.
