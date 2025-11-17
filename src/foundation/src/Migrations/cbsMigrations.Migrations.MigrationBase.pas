unit cbsMigrations.Migrations.MigrationBase;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationBase,
  cbsMigrations.Contracts.Migrations.MigrationBuilder;

type
  TMigrationBase = class abstract(TInterfacedObject, IMigrationBase)
  protected
    procedure Down(const ASchema: IMigrationBuilder); virtual;
    procedure Up(const ASchema: IMigrationBuilder); virtual; abstract;
  end;

implementation

{ TMigrationBase }

procedure TMigrationBase.Down(const ASchema: IMigrationBuilder);
begin
  // This method can be overwritten by inherited classes.
end;

end.
