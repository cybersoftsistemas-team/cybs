unit _2025_12_10_00000020_create_identity_settings_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentitySettingsTable = class(TMigration)
  private
    const TableName = 'settings';
    const SchemaName = 'identity';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateIdentitySettingsTable }

procedure CreateIdentitySettingsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
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
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentitySettingsTable);
end;

end.
