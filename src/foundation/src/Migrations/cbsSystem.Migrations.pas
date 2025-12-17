unit cbsSystem.Migrations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Migrations;

type
  TMigrations = class(TInterfacedObject, IMigrations)
  private
    procedure BeforeRun;
    procedure OnRun;
  public
    procedure Run;
  end;

implementation

uses
{PROJECT}
  cbsMigrations.Support.Migration,
  cbsSystem.Support.Migrations.Execute;

{ TMigrations }

procedure TMigrations.BeforeRun;
begin
end;

procedure TMigrations.OnRun;
begin
end;

procedure TMigrations.Run;
begin
  BeforeRun;
  OnRun;
end;

end.
