unit cbsSystem.Contracts.Migrations;

interface

uses
{SPRING}
  Spring.Collections;

type
  IMigrations = interface(IUnknown)
    ['{D95EA6B0-433A-491D-9474-9A4B5D8B5BAC}']
    procedure Run;
  end;

implementation

end.
