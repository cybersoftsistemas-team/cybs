unit _00000000_00000100_create_general_categories_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateGeneralCategoriesTable = class(TMigration)
  private
    const SchemaName = 'general';
    const TableName = 'categories';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateGeneralCategoriesTable }

procedure CreateGeneralCategoriesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Name').HasMaxLength(255).IsUnicode.IsRequired
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

initialization
begin
  RegisterMigration(TDbContext, CreateGeneralCategoriesTable);
end;

end.

