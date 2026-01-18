unit _00000001_00000100_create_general_categories_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateGeneralCategoriesTable = class(TMigration)
  private
    const TableName = 'categories';
    const SchemaName = 'general';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateGeneralCategoriesTable }

procedure CreateGeneralCategoriesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
    ,GuidColumn('ParentId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('ParentId', TableName, 'Id')
    ,Unique(['ParentId', 'Name'])
    ,CheckConstraint(Format('chk_%s_%s_no_self_parent', [SchemaName, TableName]), '(ParentId IS NULL OR ParentId <> Id)')
   ])
   .Indexes([
     CreateIndex('ParentId')
    ,CreateIndex(['ParentId', 'Id'])
   ]);
end;

procedure CreateGeneralCategoriesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
