unit cbsMigrations.Contracts.Schema.Builders;

interface

uses
{PROJECT}
  cbsMigrations.Schema.Builder,
  cbsMigrations.Schema.Types,
{SPRING}
  Spring.Collections;

type
  IBuilders = interface(IUnknown)
    ['{9E5E01DA-EADC-4F79-9450-88A45929FD6A}']
    function Add(const ADriverID: DriverID; const ABuilderType: BuilderType): IBuilders;
    function GetDriver(const ADriverID: DriverID): BuilderType;
    property Driver[const ADriverID: DriverID]: BuilderType read GetDriver; default;
  end;

  IBuilderList = IDictionary<DriverID, BuilderType>;

  function CreateBuilderList: IBuilderList;

implementation

function CreateBuilderList: IBuilderList;
begin
  Result := TCollections.CreateDictionary<DriverID, BuilderType>;
end;

end.
