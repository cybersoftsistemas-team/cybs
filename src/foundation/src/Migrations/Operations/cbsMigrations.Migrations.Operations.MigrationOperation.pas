unit cbsMigrations.Migrations.Operations.MigrationOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.MigrationOperation;

type
  TMigrationOperation = class abstract(TInterfacedObject, IMigrationOperation)
  protected
    procedure DoPrepare; virtual; abstract;
  public
    procedure Prepare;
  end;
implementation

{ TMigrationOperation }

procedure TMigrationOperation.Prepare;
begin
  DoPrepare;
end;

end.
