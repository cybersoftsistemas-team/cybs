unit _00000001_00002000_create_person_emails_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonEmailsTable = class(TMigration)
  private
    const TableName = 'emails';
    const SchemaName = 'person';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreatePersonEmailsTable }

procedure CreatePersonEmailsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('PersonId').IsRequired
    ,GuidColumn('TypeId').IsRequired
    ,StringColumn('Address').HasMaxLength(255).IsUnicode.IsRequired
   ])
   .Constraints([
     PrimaryKey(['PersonId', 'TypeId'])
    ,ForeignKey('PersonId', 'persons', 'Id')
    ,ForeignKey('TypeId', 'categories', 'Id').HasPrincipalSchema('general')
    ,Unique(['PersonId', 'Address'])
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

end.
