unit cbsSystem.Infrastructure.Migrations._2025_12_08_00000001_create_auxiliary_data_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateAuxiliaryDataSchema = class(TMigration)
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  cbsSystem.Migrations.DbSystemContext;

{ CreateAuxiliaryDataSchema }

procedure CreateAuxiliaryDataSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema('auxiliary_data');
end;

procedure CreateAuxiliaryDataSchema.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropSchema('auxiliary_data')
end;

initialization
begin
  RegisterMigration(TDbSystemContext, CreateAuxiliaryDataSchema);
end;

end.
