unit cbsSystem.Support.Migrations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Migrations;

  function Migrations: IMigrations;

implementation

uses
{PROJECT}
  cbsSystem.Migrations;

var
  InternalMigrations: IMigrations;

function Migrations: IMigrations;
begin
  Result := InternalMigrations;
end;

initialization
begin
  InternalMigrations := TMigrations.Create;
end;

finalization
begin
  InternalMigrations := nil;
end;

end.
