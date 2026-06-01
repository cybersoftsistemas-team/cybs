unit _00000025_00000800_create_identity_settings_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentitySettingsTable = class(TMigration)
  private
    const SchemaName = 'identity';
    const TableName  = 'settings';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateIdentitySettingsTable }

procedure CreateIdentitySettingsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,GuidColumn('UserId').IsRequired
   ,GuidColumn('OptionId').IsRequired
   ,BooleanColumn('Checked').HasDefaultValueSql('0').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('UserId', 'users', 'Id')
   ,ForeignKey('OptionId', 'options', 'Id')
  ])
  .Indexes([
    CreateIndex('OptionId')
   ,CreateIndex('UserId')
   ,CreateIndex(['UserId', 'OptionId'])
    .HasInclude('Checked')
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
