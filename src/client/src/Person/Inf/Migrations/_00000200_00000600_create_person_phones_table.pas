unit _00000200_00000600_create_person_phones_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreatePersonPhonesTable = class(TMigration)
  private
    const TableName = 'phones';
    const SchemaName = 'person';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreatePersonPhonesTable }

procedure CreatePersonPhonesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,GuidColumn('PersonId').IsRequired
   ,GuidColumn('TypeId').IsRequired
   ,StringColumn('Number').HasMaxLength(9).IsUnicode.IsRequired
   ,GuidColumn('CityId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('CityId', 'cities', 'Id').HasPrincipalSchema('address')
   ,ForeignKey('PersonId', 'persons', 'Id')
   ,ForeignKey('TypeId', 'categories', 'Id').HasPrincipalSchema('general')
   ,Unique(['PersonId', 'TypeId'])
  ])
  .Indexes([
    CreateIndex('CityId')
   ,CreateIndex('PersonId')
   ,CreateIndex('TypeId')
  ]);

  ASchema.AddDefaultValue('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');
end;

procedure CreatePersonPhonesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreatePersonPhonesTable);
end;

end.
