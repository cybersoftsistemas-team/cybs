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
  GMigrations: IMigrations;

function Migrations: IMigrations;
begin
  Result := GMigrations;
end;

initialization
begin
  GMigrations := TMigrations.Create;
end;

finalization
begin
  GMigrations := nil;
end;

end.
