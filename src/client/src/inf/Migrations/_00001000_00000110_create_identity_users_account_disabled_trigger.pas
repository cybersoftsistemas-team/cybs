unit _00001000_00000110_create_identity_users_account_disabled_trigger;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityUsersAccountDisabledTrigger = class(TMigration)
  private
    const TableName = 'users';
    const SchemaName = 'identity';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMain.inf.DbContext,
  cbsUAuth.dom.Common.Identity.SystemOptions;

{ CreateIdentityUsersAccountDisabledTrigger }

procedure CreateIdentityUsersAccountDisabledTrigger.Up(const ASchema: IMigrationBuilder);
begin
  // Conta desabilitada
  var AccountDisabledId :=
    TSystemOptions.AccountDisabledId.ToString.Replace('{','').Replace('}','');
  ASchema.Sql(
  'CREATE TRIGGER ' + SchemaName + '_' + TableName + '_account_disabled_trigger ' +
  'ON [' + SchemaName + '].[' + TableName + ']                                  ' +
  'AFTER INSERT, UPDATE                                                         ' +
  'AS                                                                           ' +
  'BEGIN                                                                        ' +
  '    SET NOCOUNT ON;                                                          ' +
  '    IF TRIGGER_NESTLEVEL() > 1 RETURN;                                       ' +
  '    MERGE [identity].[settings] AS target                                    ' +
  '    USING (                                                                  ' +
  '        SELECT                                                               ' +
  '            i.Id AS UserId,                                                  ' +
  '            CAST(i.AccountDisabled AS bit) AS Checked                        ' +
  '        FROM inserted i                                                      ' +
  '    ) AS source                                                              ' +
  '    ON target.UserId = source.UserId                                         ' +
  '       AND target.OptionId = ''' + AccountDisabledId + '''                   ' +
  '    WHEN MATCHED AND target.Checked <> source.Checked THEN                   ' +
  '        UPDATE SET Checked = source.Checked                                  ' +
  '    WHEN NOT MATCHED THEN                                                    ' +
  '        INSERT (UserId, OptionId, Checked)                                   ' +
  '        VALUES (                                                             ' +
  '            source.UserId,                                                   ' +
  '            ''' + AccountDisabledId + ''',                                   ' +
  '            source.Checked                                                   ' +
  '        );                                                                   ' +
  'END;                                                                         ' );
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityUsersAccountDisabledTrigger);
end;

end.
