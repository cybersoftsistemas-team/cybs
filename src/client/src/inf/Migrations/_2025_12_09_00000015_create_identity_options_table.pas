unit _2025_12_09_00000015_create_identity_options_table;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateIdentityOptionsTable = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsUAuth.inf.DbUAuthContext;

{ CreateIdentityOptionsTable }

procedure CreateIdentityOptionsTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.CreateTable('options')
   .HasSchema('identity')
   .Columns([
     GuidColumn('Id').HasDefaultValueSql('NEWID()').IsRequired
    ,StringColumn('Name').HasMaxLength(255).IsRequired
    ,StringColumn('Description').HasColumnType('ntext').IsRequired
   ])
   .Constraints([
     PrimaryKey('Id')
    ,Unique('Name')
   ]);
end;

procedure CreateIdentityOptionsTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropTable('options')
   .HasSchema('identity');
end;

initialization
begin
  RegisterMigration(TDbUAuthContext, CreateIdentityOptionsTable);
end;

end.
