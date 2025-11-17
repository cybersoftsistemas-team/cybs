unit cbsMigrationsFireDac.Schema.SqlServerBuilder;

interface

uses
{PROJECT}
  cbsMigrationsFireDac.Schema.Builder;

type
  TFDSqlServerBuilder = class(TFDBuilder)
  public
    function HasTable(const ATable: string): Boolean; override;
  end;

implementation

uses
{IDE}
  System.SysUtils;

{ TFDSqlServerBuilder }

function TFDSqlServerBuilder.HasTable(const ATable: string): Boolean;
begin
  var LParts := ParseSchemaAndTable(ATable);
  var LSelCommand := Resolver.CreateCommand;
  try
    LSelCommand.Open(Grammar.CompileTableExists(LParts.Schema, LParts.Table).CommandText);
    Result := inherited HasTable(LSelCommand);
  finally
    FreeAndNil(LSelCommand);
  end;
end;

end.
