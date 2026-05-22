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
    IntColumn('Id').IsRequired
   ,IntColumn('LockoutMinutes').IsRequired
   ,IntColumn('MaxAttempts').IsRequired
   ,IntColumn('PasswordIterations').IsRequired
  ])
  .Constraints([
    PrimaryKey('Id')
   ,CheckConstraint(Format('%s_%s_singleton_check', [SchemaName, TableName]), '(Id = 1)')
  ]);

  ASchema.AddDefault('Id', '1')
  .HasTable(TableName)
  .HasSchema(SchemaName);

  ASchema.AddDefault('LockoutMinutes', '15')
  .HasTable(TableName)
  .HasSchema(SchemaName);

  ASchema.AddDefault('MaxAttempts', '5')
  .HasTable(TableName)
  .HasSchema(SchemaName);

  ASchema.AddDefault('PasswordIterations', '125000')
  .HasTable(TableName)
  .HasSchema(SchemaName);
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

