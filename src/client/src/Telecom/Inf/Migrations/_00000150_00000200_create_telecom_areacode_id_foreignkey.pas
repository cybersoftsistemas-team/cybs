unit _00000150_00000200_create_telecom_areacode_id_foreignkey;

interface

uses
{PROJECT}
  cbsMigrations.Support.Migration;

type
  CreateTelecomAreaCodeIdTable = class(TMigration)
  private
    const TableName = 'areacodes';
    const SchemaName = 'telecom';
  protected
    procedure Up(const ASchema: IMigrationBuilder); override;
    procedure Down(const ASchema: IMigrationBuilder); override;
  end;

implementation

uses
{PROJECT}
  Shared.Inf.Database.Context;

{ CreateTelecomAreaCodeIdTable }

procedure CreateTelecomAreaCodeIdTable.Up(const ASchema: IMigrationBuilder);
begin
  ASchema.AddForeignKey('cities', ['AreaCodeId'], TableName, ['Id'])
  .HasSchema('address')
  .HasPrincipalSchema(SchemaName);
end;

procedure CreateTelecomAreaCodeIdTable.Down(const ASchema: IMigrationBuilder);
begin
  ASchema.DropForeignKey('address_cities_AreaCodeId_foreign');
end;

initialization
begin
  RegisterMigration(TDbContext, CreateTelecomAreaCodeIdTable);
end;

end.
