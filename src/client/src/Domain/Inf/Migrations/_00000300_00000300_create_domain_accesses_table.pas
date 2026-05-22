unit _00000300_00000300_create_domain_accesses_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateDomainAccessesTable = class(TMigration)
  private
    const TableName = 'accesses';
    const SchemaName = 'domain';
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
    GuidColumn('Id').IsRequired
   ,BooleanColumn('Reserved').IsRequired
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

  ASchema.AddDefault('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');

  ASchema.AddDefault('Reserved')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('0');
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
