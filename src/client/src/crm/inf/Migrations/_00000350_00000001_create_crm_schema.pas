unit _00000350_00000001_create_crm_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateCrmSchema = class(TMigration)
  private
    const SchemaName = 'crm';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateCrmSchema }

procedure CreateCrmSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateCrmSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName)
end;

initialization
begin
  RegisterMigration(TDbContext, CreateCrmSchema);
end;

end.
