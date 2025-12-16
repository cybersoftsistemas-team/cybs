unit _2025_12_09_00000005_create_general_categories_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateGeneralCategoriesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext;

{ CreateGeneralCategoriesTable }

procedure CreateGeneralCategoriesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('categories')
   .HasSchema('general')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
    ,GuidColumn('ParentId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('ParentId', 'categories', 'Id')
    ,Unique(['ParentId', 'Name'])
   ])
   .Indexes([
     CreateIndex('ParentId')
    ,CreateIndex(['ParentId', 'Id'])
   ]);
end;

procedure CreateGeneralCategoriesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('categories')
   .HasSchema('general');
end;

initialization
begin
  RegisterMigration(TDbContext, CreateGeneralCategoriesTable);
end;

end.
