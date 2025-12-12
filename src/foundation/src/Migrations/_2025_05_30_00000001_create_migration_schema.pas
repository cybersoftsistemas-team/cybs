unit _2025_05_30_00000001_create_migration_schema;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateMigrationSchema = class(TMigration)
  private
    FName: string;
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
  public
    constructor Create(const ADriverID: DriverID; const AName: string);
  end;

implementation

{ CreateMigrationSchema }

constructor CreateMigrationSchema.Create(const ADriverID: DriverID; const AName: string);
begin
  inherited Create(ADriverID);
  FName := AName;
end;

procedure CreateMigrationSchema.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.EnsureSchema(FName);
end;

end.
