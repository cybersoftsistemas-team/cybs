unit _00000250_00000800_create_identity_settings_table;

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
  Shared.Inf.Database.Context;

{ CreateIdentitySettingsTable }

procedure CreateIdentitySettingsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,GuidColumn('UserId').IsRequired
   ,GuidColumn('OptionId').IsRequired
   ,BooleanColumn('Checked').IsRequired
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

  ASchema.AddDefault('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');

  ASchema.AddDefault('Checked')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('0');
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
