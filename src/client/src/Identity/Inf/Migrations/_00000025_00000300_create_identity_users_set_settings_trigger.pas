unit _00000025_00000300_create_identity_users_set_settings_trigger;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityUsersSetSettingsTrigger = class(TMigration)
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
  Shared.Inf.Database.Context;

{ CreateIdentityUsersSetSettingsTrigger }

procedure CreateIdentityUsersSetSettingsTrigger.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.Sql(
  Format('CREATE TRIGGER %s_%s_set_settings_trigger ', [SchemaName, TableName]) +
  Format('ON [%s].[%s] ', [SchemaName, TableName])                              +
         'AFTER INSERT, UPDATE                                                ' +
         'AS                                                                  ' +
         'BEGIN                                                               ' +
         '  SET NOCOUNT ON;                                                   ' +
         '  IF TRIGGER_NESTLEVEL() > 1                                        ' +
         '        RETURN;                                                     ' +
         '  INSERT INTO [identity].[settings] (                               ' +
         '      UserId,                                                       ' +
         '      OptionId,                                                     ' +
         '      Checked                                                       ' +
         '  )                                                                 ' +
         '  SELECT                                                            ' +
         '      I.Id               AS UserId,                                 ' +
         '      O.Id               AS OptionId,                               ' +
         '      CAST(0 AS bit)     AS Checked                                 ' +
         '  FROM inserted AS I                                                ' +
         '  CROSS JOIN [identity].[options] AS O                              ' +
         '  LEFT JOIN [identity].[settings] AS S                              ' +
         '    ON  S.UserId   = I.Id                                           ' +
         '    AND S.OptionId = O.Id                                           ' +
         '  WHERE S.UserId IS NULL;                                           ' +
         'END;                                                                ' );
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityUsersSetSettingsTrigger);
end;

end.
