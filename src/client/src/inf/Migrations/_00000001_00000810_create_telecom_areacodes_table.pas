unit _00000001_00000810_create_telecom_areacodes_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateTelecomAreaCodesSchema = class(TMigration)
  private
    const TableName = 'areacodes';
    const SchemaName = 'telecom';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

{ CreateTelecomAreaCodesSchema }

procedure CreateTelecomAreaCodesSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
   .HasSchema(SchemaName)
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
    ,StringColumn('AreaCode').HasMaxLength(5).HasUnicode(True).HasUnicode(True).IsRequired
    ,GuidColumn('StateId').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,ForeignKey('StateId', 'states', 'Id').HasPrincipalSchema('address')
    ,Unique(['StateId', 'AreaCode'])
   ])
   .Indexes([
     CreateIndex('StateId')
   ]);
end;

procedure CreateTelecomAreaCodesSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
   .HasSchema(SchemaName);
end;

end.
