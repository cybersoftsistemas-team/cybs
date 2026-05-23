unit _00000250_00000100_create_identity_configs_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityConfigsTable = class(TMigration)
  private
    const TableName = 'configs';
    const SchemaName = 'identity';
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

{ CreateIdentityConfigsTable }

procedure CreateIdentityConfigsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable(TableName)
  .HasSchema(SchemaName)
  .Columns([
    IntColumn('Id').HasDefaultValueSql('1').IsRequired
   ,IntColumn('LockoutMinutes').HasDefaultValueSql('15').IsRequired
   ,IntColumn('MaxAttempts').HasDefaultValueSql('5').IsRequired
   ,IntColumn('PasswordIterations').HasDefaultValueSql('125000').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,CheckConstraint(Format('%s_%s_singleton_check', [SchemaName, TableName]), '(Id = 1)')
  ]);
end;

procedure CreateIdentityConfigsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable(TableName)
  .HasSchema(SchemaName);
end;

initialization
begin
  RegisterMigration(TDbContext, CreateIdentityConfigsTable);
end;

end.

