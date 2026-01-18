unit _00001000_00000800_create_domain_persons_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateyDomainPersonsTable = class(TMigration)
  private
    const TableName = 'persons';
    const SchemaName = 'domain';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateyDomainPersonsTable }

procedure CreateyDomainPersonsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('DomainId').IsRequired
    ,GuidColumn('PersonId').IsRequired
   ])
   .Constraints([
     PrimaryKey(['DomainId', 'PersonId'])
    ,ForeignKey('DomainId', 'domains', 'Id')
    ,ForeignKey('PersonId', 'persons', 'Id').HasPrincipalSchema('person')
   ])
   .Indexes([
     CreateIndex('DomainId')
    ,CreateIndex('PersonId')
   ]);
end;

procedure CreateyDomainPersonsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateyDomainPersonsTable);
end;

end.
