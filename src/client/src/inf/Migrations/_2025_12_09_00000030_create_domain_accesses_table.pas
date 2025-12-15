unit _2025_12_09_00000030_create_domain_accesses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateDomainAccessesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateDomainAccessesTable }

procedure CreateDomainAccessesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('accesses')
   .HasSchema('domain')
   .Columns([
     GuidColumn('DomainId').IsRequired
    ,GuidColumn('UserId').IsRequired
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
   ])
   .Constraints([
     PrimaryKey(['DomainId', 'UserId'])
    ,ForeignKey('DomainId', 'domains', 'Id')
    ,ForeignKey('UserId', 'users', 'Id').HasPrincipalSchema('identity')
   ]);
end;

procedure CreateDomainAccessesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('accesses')
   .HasSchema('domain');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateDomainAccessesTable);
end;

end.
