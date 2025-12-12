unit _2025_05_30_00000002_create_migrations_history_table;

interface

uses
{PROJECT}
  cbsMigrations.Schema.Types,
  cbsMigrations.Support.Migration;

type
  CreateMigrationsHistoryTable = class(TMigration)
  private
    FDefaultSchema: string;
    FDefaultTableName: string;
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
  public
    constructor Create(const ADriverID: DriverID; const ADefaultSchema, ADefaultTableName: string);
  end;

implementation

{ CreateMigrationsHistoryTable }

constructor CreateMigrationsHistoryTable.Create(const ADriverID: DriverID; const ADefaultSchema, ADefaultTableName: string);
begin
  inherited Create(ADriverID);
  FDefaultSchema := ADefaultSchema;
  FDefaultTableName := ADefaultTableName;
end;

procedure CreateMigrationsHistoryTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(FDefaultTableName)
   .HasSchema(FDefaultSchema)
   .Columns([
     StringColumn('Migration').HasMaxLength(255).IsRequired
    ,IntColumn('Batch').IsRequired
    ,DateTimeColumn('CreatedAt').IsRequired
   ])
   .Constraints([
     PrimaryKey('Migration')
   ])
   .Indexes([
     CreateIndex('Batch')
   ]);
end;

end.
