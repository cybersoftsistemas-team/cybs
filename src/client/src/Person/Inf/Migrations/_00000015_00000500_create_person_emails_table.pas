unit _00000015_00000500_create_person_emails_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonEmailsTable = class(TMigration)
  private
    const SchemaName = 'person';
    const TableName  = 'emails';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreatePersonEmailsTable }

procedure CreatePersonEmailsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,GuidColumn('PersonId').IsRequired
   ,GuidColumn('TypeId').IsRequired
   ,StringColumn('Address').HasMaxLength(255).IsUnicode.IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('PersonId', 'persons', 'Id')
   ,ForeignKey('TypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ,Unique(['PersonId', 'Address'])
   ,Unique(['PersonId', 'TypeId'])
   ,CheckConstraint(
    SchemaName + '_' + TableName + '_Address_valid_check',
    'Address LIKE ''%_@_%._%''  AND    ' +
    'Address NOT LIKE ''% %''   AND    ' +
    'Address NOT LIKE ''%..%''  AND    ' +
    'Address NOT LIKE ''@%''    AND    ' +
    'Address NOT LIKE ''%@%@%'' AND    ' +
    'LEN(Address) BETWEEN 5     AND 255'
    )
  ])
  .Indexes([
    CreateIndex('PersonId')
   ,CreateIndex('TypeId')
  ]);
end;

procedure CreatePersonEmailsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreatePersonEmailsTable);
end;

end.
