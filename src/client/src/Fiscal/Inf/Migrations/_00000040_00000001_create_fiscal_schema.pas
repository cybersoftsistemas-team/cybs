unit _00000040_00000001_create_fiscal_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateFiscalSchema = class(TMigration)
  private
    const SchemaName = 'fiscal';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateFiscalSchema }

procedure CreateFiscalSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(SchemaName);
end;

procedure CreateFiscalSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema(SchemaName)
end;

initialization
begin
  RegisterMigration(TDbContext, CreateFiscalSchema);
end;

end.
