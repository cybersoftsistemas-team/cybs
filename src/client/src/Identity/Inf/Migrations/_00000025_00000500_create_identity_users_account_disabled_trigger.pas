unit _00000025_00000500_create_identity_users_account_disabled_trigger;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityUsersAccountDisabledTrigger = class(TMigration)
  private
    const SchemaName = 'identity';
    const TableName  = 'users';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  Identity.Dom.Common.SystemOptions,
  Shared.Inf.Database.Context;

{ CreateIdentityUsersAccountDisabledTrigger }

procedure CreateIdentityUsersAccountDisabledTrigger.Up(const ASchema: IMigrationBuilder);
begin
  // Conta desabilitada
  var AccountDisabledId :=
    TSystemOptions.AccountDisabledId.ToString.Replace('{','').Replace('}','');
  ASchema.Sql(
  Format('CREATE TRIGGER %s_%s_account_disabled_trigger ', [SchemaName, TableName]) +
  Format('ON [%s].[%s] ', [SchemaName, TableName])                                  +
  'AFTER INSERT, UPDATE                                                           ' +
  'AS                                                                             ' +
  'BEGIN                                                                          ' +
  '    SET NOCOUNT ON;                                                            ' +
  '    IF TRIGGER_NESTLEVEL() > 1 RETURN;                                         ' +
  '    MERGE [identity].[settings] AS target                                      ' +
  '    USING (                                                                    ' +
  '        SELECT                                                                 ' +
  '            i.Id AS UserId,                                                    ' +
  '            CAST(i.AccountDisabled AS bit) AS Checked                          ' +
  '        FROM inserted i                                                        ' +
  '    ) AS source                                                                ' +
  '    ON target.UserId = source.UserId                                           ' +
  Format(' AND target.OptionId = ''%s''', [AccountDisabledId])                      +
  '    WHEN MATCHED AND target.Checked <> source.Checked THEN                     ' +
  '        UPDATE SET Checked = source.Checked                                    ' +
  '    WHEN NOT MATCHED THEN                                                      ' +
  '        INSERT (UserId, OptionId, Checked)                                     ' +
  '        VALUES (                                                               ' +
  '            source.UserId,                                                     ' +
  Format('     ''%s'',', [AccountDisabledId])                                       +
  '            source.Checked                                                     ' +
  '        );                                                                     ' +
  'END;                                                                           ' );
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityUsersAccountDisabledTrigger);
end;

end.
