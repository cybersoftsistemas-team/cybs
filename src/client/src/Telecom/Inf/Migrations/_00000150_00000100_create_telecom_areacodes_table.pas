unit _00000150_00000100_create_telecom_areacodes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateTelecomAreaCodesTable = class(TMigration)
  private
    const TableName = 'areacodes';
    const SchemaName = 'telecom';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateTelecomAreaCodesTable }

procedure CreateTelecomAreaCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').IsRequired
   ,StringColumn('AreaCode').HasMaxLength(5).IsUnicode.IsRequired
   ,GuidColumn('StateId').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,ForeignKey('StateId', 'states', 'Id').HasPrincipalSchema('address')
   ,Unique(['StateId', 'AreaCode'])
  ])
  .Indexes([
    CreateIndex('AreaCode')
   ,CreateIndex('StateId')
  ]);

  ASchema.AddDefaultValue('Id')
  .HasTable(TableName)
  .HasSchema(SchemaName)
  .HasValue('NEWSEQUENTIALID()');
end;

procedure CreateTelecomAreaCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateTelecomAreaCodesTable);
end;

end.

