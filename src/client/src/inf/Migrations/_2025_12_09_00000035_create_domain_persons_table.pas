unit _2025_12_09_00000035_create_domain_persons_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateyDomainPersonsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateyDomainPersonsTable }

procedure CreateyDomainPersonsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('persons')
   .HasSchema('domain')
   .Columns([
     GuidColumn('DomainId').IsRequired
    ,GuidColumn('PersonId').IsRequired
   ])
   .Constraints([
     PrimaryKey(['DomainId', 'PersonId'])
    ,ForeignKey('DomainId', 'domains', 'Id')
    ,ForeignKey('PersonId', 'persons', 'Id').HasPrincipalSchema('person')
   ]);
end;

procedure CreateyDomainPersonsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('persons')
   .HasSchema('domain');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateyDomainPersonsTable);
end;

end.
