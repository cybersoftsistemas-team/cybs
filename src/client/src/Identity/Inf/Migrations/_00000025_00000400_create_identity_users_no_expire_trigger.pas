unit _00000025_00000400_create_identity_users_no_expire_trigger;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityUsersNoExpireTrigger = class(TMigration)
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

{ CreateIdentityUsersNoExpireTrigger }

procedure CreateIdentityUsersNoExpireTrigger.Up(const ASchema: IMigrationBuilder);
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
         '  JOIN inserted i                                                ' +
         '  ON i.Id = u.Id                                                 ' +
         '  JOIN [identity].[settings] s                                   ' +
         '  ON s.UserId = u.Id                                             ' +
  Format('  WHERE s.OptionId = ''%s''', [PasswordNeverExpiresId])            +
         '  AND s.Checked = 1                                              ' +
         '  AND u.AccountExpiresDate IS NOT NULL;                          ' +
         'END;                                                             ' );
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityUsersNoExpireTrigger);
end;

end.
