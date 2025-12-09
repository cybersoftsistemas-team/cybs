unit cbsSystem.Contracts.Migrations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Module,
  cbsSystem.Contracts.Module.Manager,
{SPRING}
  Spring.Collections;

type
  IMigrations = interface(IUnknown)
    ['{D95EA6B0-433A-491D-9474-9A4B5D8B5BAC}']
    procedure Run(const AModules: IModuleManager);
  end;

  IModuleList = IList<IModule>;
  IGraphList = IDictionary<string, IModuleList>;
  IVisitedList = IDictionary<string, Boolean>;

  function CreateGraphList: IGraphList;
  function CreateModuleList: IModuleList;
  function CreateVisitedList: IVisitedList;

implementation

function CreateGraphList: IGraphList;
begin
  Result := TCollections.CreateDictionary<string, IModuleList>;
end;

function CreateModuleList: IModuleList;
begin
  Result := TCollections.CreateList<IModule>;
end;

function CreateVisitedList: IVisitedList;
begin
  Result := TCollections.CreateDictionary<string, Boolean>;
end;

end.
