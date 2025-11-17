unit cbsMigrations.Contracts.Migrations.MigrationBase;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationBuilder;

type
  IMigrationBase = interface(IUnknown)
    ['{ABCAAE3B-1478-49C6-92E8-FEEEC8D1ADD0}']
    procedure Down(const ASchema: IMigrationBuilder);
    procedure Up(const ASchema: IMigrationBuilder);
  end;

implementation

end.
