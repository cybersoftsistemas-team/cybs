unit _00000040_00000100_create_fiscal_ncms_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateFiscalNcmsTable = class(TMigration)
  private
    const SchemaName = 'fiscal';
    const TableName  = 'ncms';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateFiscalNcmsTable }

procedure CreateFiscalNcmsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    GuidColumn('Id').HasDefaultValueSql('NEWSEQUENTIALID()').IsRequired
   ,StringColumn('Code').HasMaxLength(8).IsUnicode.IsRequired
   ,StringColumn('Description').HasMaxLength(1000).IsUnicode.IsRequired
   ,DateTimeColumn('StartValidity').IsOptional
   ,DateTimeColumn('EndValidity').IsOptional
   ,BooleanColumn('Active').HasDefaultValueSql('1').IsRequired
   ,StringColumn('ExTipi').HasMaxLength(10).IsUnicode.IsOptional
   ,DateTimeColumn('PublishedAt').IsOptional
  ])
  .Constraints([
    PrimaryKey('Id')
   ,Unique('Code')
  ])
  .Indexes([
    CreateIndex('Description')
   ,CreateIndex('Active')
   ,CreateIndex(['Active', 'Code'])
  ]);
end;

procedure CreateFiscalNcmsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateFiscalNcmsTable);
end;

end.
