unit _00000001_00000810_create_telecom_areacodes_table;

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

{ CreateTelecomAreaCodesTable }

procedure CreateTelecomAreaCodesTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
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
end;

procedure CreateTelecomAreaCodesTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.

