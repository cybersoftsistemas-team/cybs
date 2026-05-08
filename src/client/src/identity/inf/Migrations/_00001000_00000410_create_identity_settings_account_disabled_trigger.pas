unit _00001000_00000410_create_identity_settings_account_disabled_trigger;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentitySettingsAccountDisabledTrigger = class(TMigration)
  private
    const TableName = 'settings';
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
  cbsUAuth.dom.Identity.Common.SystemOptions;

{ CreateIdentitySettingsAccountDisabledTrigger }

procedure CreateIdentitySettingsAccountDisabledTrigger.Up(const ASchema: IMigrationBuilder);
begin
  // Conta desabilitada
  var AccountDisabledId :=
    TSystemOptions.AccountDisabledId.ToString.Replace('{','').Replace('}','');
  ASchema.Sql(
  Format('CREATE TRIGGER %s_%s_account_disabled_trigger ', [SchemaName, TableName]) +
  Format('ON [%s].[%s] ', [SchemaName, TableName])                                  +
         'AFTER INSERT, UPDATE                                                    ' +
         'AS                                                                      ' +
         'BEGIN                                                                   ' +
         '    SET NOCOUNT ON;                                                     ' +
         '    IF TRIGGER_NESTLEVEL() > 1 RETURN;                                  ' +
         '    UPDATE u                                                            ' +
         '       SET u.AccountDisabled = s.Checked                                ' +
         '    FROM [identity].[users] u                                           ' +
         '    JOIN inserted s                                                     ' +
         '        ON s.UserId = u.Id                                              ' +
  Format('    WHERE s.OptionId = ''%s''', [AccountDisabledId])                      +
         '    AND u.AccountDisabled <> s.Checked;                                 ' +
         'END;                                                                    ' );
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentitySettingsAccountDisabledTrigger);
end;

end.
