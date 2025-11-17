unit cbsMigrations.Contracts.Migrations.MappedColumnType;

interface

uses
{PROJECT}
  cbsMigrations.Schema.Types;

type
  IMappedColumnType = interface(IUnknown)
    ['{0156FDB4-CB78-4FC5-8566-E022C695AF9A}']
    function GetColumnType: TGUID;
    function GetDbType: TDbType;
    function GetDriverID: DriverID;
    property ColumnType: TGUID read GetColumnType;
    property DbType: TDbType read GetDbType;
    property DriverID: DriverID read GetDriverID;
  end;

implementation

end.
