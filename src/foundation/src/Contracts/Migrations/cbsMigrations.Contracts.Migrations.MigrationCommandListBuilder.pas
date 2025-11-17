unit cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.MigrationCommand,
{SPRING}
  Spring.Collections;

type
  IMigrationCommands = IEnumerable<IMigrationCommand>;

  IMigrationCommandListBuilder = interface(IUnknown)
    ['{CD3FA0BE-EEC2-4AE6-8F37-94CDE3F08264}']
    function Append(const AValue: string): IMigrationCommandListBuilder;
    function AppendCommands(const AMigrationCommands: IMigrationCommands): IMigrationCommandListBuilder;
    function AppendLine: IMigrationCommandListBuilder; overload;
    function AppendLine(const AValue: string): IMigrationCommandListBuilder; overload;
    function CommandList: IMigrationCommands;
    function EndCommand: IMigrationCommandListBuilder;
  end;

  ICommandList = IList<IMigrationCommand>;

  function CreateCommandList: ICommandList;

implementation

function CreateCommandList: ICommandList;
begin
  Result := TCollections.CreateInterfaceList<IMigrationCommand>;
end;

end.
