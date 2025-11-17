unit cbsMigrations.Contracts.Migrations.MappedColumnTypes;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MappedColumnType,
  cbsMigrations.Schema.Types,
{SPRING}
  Spring.Collections;

type
  IMappedColumnTypes = interface(IUnknown)
    ['{45850184-17F0-4403-B070-264251F78761}']
    function GetDbType(const AColumnOperation: IInterface; const ADriverID: DriverID): string;
  end;

  IMappedColumnTypeList = IList<IMappedColumnType>;

  function CreateMappedColumnTypeList: IMappedColumnTypeList;

implementation

function CreateMappedColumnTypeList: IMappedColumnTypeList;
begin
  Result := TCollections.CreateInterfaceList<IMappedColumnType>;
end;

end.
