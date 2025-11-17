unit cbsMigrations.Migrations.Operations.SqlOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.SqlOperation,
  cbsMigrations.Migrations.Operations.MigrationOperation;

type
  TSqlOperation = class(TMigrationOperation, ISqlOperation)
  private
    FSql: string;
    function GetSql: string;
  protected
    procedure DoPrepare; override;
  public
    function HasSql(const ASql: string): ISqlOperation;
    property Sql: string read GetSql;
  end;

implementation

{ TSqlOperation }

function TSqlOperation.GetSql: string;
begin
  Result := FSql;
end;

function TSqlOperation.HasSql(const ASql: string): ISqlOperation;
begin
  FSql := ASql;
  Result := Self;
end;

procedure TSqlOperation.DoPrepare;
begin
  // This method can be overwritten by inherited classes.
end;

end.

