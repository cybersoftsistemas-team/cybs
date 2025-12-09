unit _2025_12_08_00000005_create_auxiliary_data_categories_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAuxiliaryDataCategoriesTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateAuxiliaryDataCategoriesTable }

procedure CreateAuxiliaryDataCategoriesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('categories')
   .HasSchema('auxiliary_data')
   .Columns([
     GuidColumn('Id').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,BooleanColumn('Reserved').HasDefaultValueSql('0').IsRequired
    ,GuidColumn('ParentId').IsOptional
   ])
   .Constraints([
     PrimaryKey('Id')
    ,Unique(['ParentId', 'Name'])
    ,ForeignKey('ParentId', 'categories', 'Id')
   ]);
end;

procedure CreateAuxiliaryDataCategoriesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('categories')
   .HasSchema('auxiliary_data');
end;

end.
