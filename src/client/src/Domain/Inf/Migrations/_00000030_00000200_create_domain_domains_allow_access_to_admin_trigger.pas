unit _00000030_00000200_create_domain_domains_allow_access_to_admin_trigger;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateDomainDomainsAllowAccessToAdminTrigger = class(TMigration)
  private
    const SchemaName = 'domain';
    const TableName  = 'domains';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  Shared.Core.Common.SystemUsers,
  Shared.Inf.Database.Context;

{ CreateDomainDomainsAllowAccessToAdminTrigger }

procedure CreateDomainDomainsAllowAccessToAdminTrigger.Up(const ASchema: IMigrationBuilder);
begin
  // Conta desabilitada
  var AdministratorId :=
    TSystemUsers.AdministratorId.ToString.Replace('{','').Replace('}','');
  ASchema.Sql(
  Format('CREATE TRIGGER %s_%s_allow_access_to_admin_trigger ', [SchemaName, TableName]) +
  Format('ON [%s].[%s] ', [SchemaName, TableName])                                       +
         'AFTER INSERT, UPDATE                                                         ' +
         'AS                                                                           ' +
         'BEGIN                                                                        ' +
         '    SET NOCOUNT ON;                                                          ' +
  Format('    DECLARE @UserId UNIQUEIDENTIFIER = ''%s'';', [AdministratorId])            +
         '    INSERT INTO [domain].[accesses] (DomainId, UserId, Reserved)             ' +
         '    SELECT                                                                   ' +
         '        i.Id,                                                                ' +
         '        @UserId,                                                             ' +
         '        1                                                                    ' +
         '    FROM inserted i                                                          ' +
         '    WHERE NOT EXISTS (                                                       ' +
         '        SELECT 1                                                             ' +
         '        FROM [domain].[accesses] a                                           ' +
         '        WHERE a.DomainId = i.Id                                              ' +
         '          AND a.UserId = @UserId                                             ' +
         '    );                                                                       ' +
         'END;                                                                         ' );
end;

initialization
begin
  RegisterMigration(TDbContext, CreateDomainDomainsAllowAccessToAdminTrigger);
end;

end.
