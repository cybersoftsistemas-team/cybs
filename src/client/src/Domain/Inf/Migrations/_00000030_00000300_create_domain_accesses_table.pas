unit _00000030_00000300_create_domain_accesses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateDomainAccessesTable = class(TMigration)
  private
    const SchemaName = 'domain';
    const TableName  = 'accesses';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateDomainAccessesTable }

procedure CreateDomainAccessesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
   ,GuidColumn('DomainId').IsRequired
   ,GuidColumn('UserId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('DomainId', 'domains', 'Id')
   ,ForeignKey('UserId', 'users', 'Id').HasPrincipalSchema('identity')
   ,Unique(['DomainId', 'UserId'])
  ])
  .Indexes([
    CreateIndex('DomainId')
   ,CreateIndex('UserId')
  ]);
end;

procedure CreateDomainAccessesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateDomainAccessesTable);
end;

end.
