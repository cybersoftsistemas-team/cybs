unit cbsMigrations.Contracts.Schema.SchemaAndTableParts;

interface

uses
{PROJECT}
  cbsMigrations.Schema.Types;

type
  ISchemaAndTableParts = interface(IUnknown)
    ['{76B301D8-B85F-4220-BE96-6392F8584ABA}']
    function GetSchema: TSchema;
    function GetTable: TTable;
    property Schema: TSchema read GetSchema;
    property Table: TTable read GetTable;
  end;

implementation

end.
