unit _00001000_00000805_create_identity_logins_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityLoginsTable = class(TMigration)
  private
    const TableName = 'logins';
    const SchemaName = 'identity';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateIdentityLoginsTable }

procedure CreateIdentityLoginsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
    ,DateTimeColumn('AttemptedAt').HasDefaultValueSql('GETDATE()').IsRequired
    ,StringColumn('IpAddress').HasMaxLength(45).IsUnicode.IsOptional
    ,BooleanColumn('Success').HasDefaultValueSql('0').IsRequired
    ,StringColumn('UserAgent').HasMaxLength(500).IsUnicode.IsOptional
    ,GuidColumn('DomainId').IsRequired
    ,GuidColumn('UserId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('DomainId', 'domains', 'Id').HasPrincipalSchema('domain')
    ,ForeignKey('UserId', 'users', 'Id')
   ])
   .Indexes([
     CreateIndex('DomainId')
    ,CreateIndex('UserId')
    ,CreateIndex(['UserId', 'AttemptedAt'])
     .HasDescending([False, True])
   ]);
end;

procedure CreateIdentityLoginsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityLoginsTable);
end;

end.
