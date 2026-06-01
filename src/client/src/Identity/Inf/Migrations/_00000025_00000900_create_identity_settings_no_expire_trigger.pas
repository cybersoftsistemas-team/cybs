unit _00000025_00000900_create_identity_settings_no_expire_trigger;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentitySettingsNoExpireTrigger = class(TMigration)
  private
    const SchemaName = 'identity';
    const TableName  = 'settings';
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

{ CreateIdentitySettingsNoExpireTrigger }

procedure CreateIdentitySettingsNoExpireTrigger.Up(const ASchema: IMigrationBuilder);
begin
  // A senha nunca expira
  var PasswordNeverExpiresId :=
    TSystemOptions.PasswordNeverExpires.ToString.Replace('{','').Replace('}','');
  ASchema.Sql(
  Format('CREATE TRIGGER %s_%s_no_expire_trigger ', [SchemaName, TableName]) +
  Format('ON [%s].[%s] ', [SchemaName, TableName])                           +
         'AFTER INSERT, UPDATE                                             ' +
         'AS                                                               ' +
         'BEGIN                                                            ' +
         '  SET NOCOUNT ON;                                                ' +
         '  UPDATE u                                                       ' +
         '  SET u.AccountExpiresDate = NULL                                ' +
         '  FROM [identity].[users] u                                      ' +
         '  JOIN inserted s                                                ' +
         '  ON s.UserId = u.Id                                             ' +
  Format('  WHERE s.OptionId = ''%s''', [PasswordNeverExpiresId])            +
         '  AND s.Checked = 1                                              ' +
         '  AND u.AccountExpiresDate IS NOT NULL;                          ' +
         'END;                                                             ' );
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentitySettingsNoExpireTrigger);
end;

end.
