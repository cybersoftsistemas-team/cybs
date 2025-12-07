unit cbsSystem.Migrations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Migrations,
  cbsSystem.Contracts.Module.Manager;

type
  TMigrations = class(TInterfacedObject, IMigrations)
  private
    function BuildReverseGraph(const AModules: IcbsModuleManager): IGraphList;
    procedure BeforeRun(const AModules: IcbsModuleManager);
    procedure CheckPacketCycles(const AModules: IcbsModuleManager);
    procedure DFSExec(const AModuleName: string; const AGraph: IGraphList; const AModules: IcbsModuleManager; const AVisited: IVisitedList);
    procedure OnRun(const AModules: IcbsModuleManager);
  public
    procedure Run(const AModules: IcbsModuleManager);
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Module.Manager.CycleInfo;

{ TMigrations }

function TMigrations.BuildReverseGraph(const AModules: IcbsModuleManager): IGraphList;
begin
  Result := CreateGraphList;
  for var LModule in AModules do
  begin
    for var Required in LModule.Requires do
    begin
      if not Result.ContainsKey(Required) then
      begin
        Result[Required] := CreateModuleList;
      end;
      Result[Required].Add(LModule);
    end;
  end;
end;

procedure TMigrations.BeforeRun(const AModules: IcbsModuleManager);
begin
  CheckPacketCycles(AModules);
end;

procedure TMigrations.CheckPacketCycles(const AModules: IcbsModuleManager);
begin
  var LCycle := DetectCircularDependencies(AModules);
  if LCycle.HasCycle then
  begin
    raise Exception.Create('Dependências circulares detectadas!' +
      sLineBreak + String.Join(' → ', LCycle.Path));
  end;
end;

procedure TMigrations.DFSExec(const AModuleName: string; const AGraph: IGraphList; const AModules: IcbsModuleManager; const AVisited: IVisitedList);
begin
  if AVisited.ContainsKey(AModuleName) then
  begin
    Exit;
  end;
  AVisited[AModuleName] := True;
  for var LDep in AModules do if
    SameText(LDep.Name, AModuleName) then
  begin
    LDep.ExecuteMigrations;
  end;
  var LDependents: IModuleList;
  if AGraph.TryGetValue(AModuleName, LDependents) then
  begin
    for var LDep in LDependents do
    begin
      DFSExec(LDep.Name, AGraph, AModules, AVisited);
    end;
  end;
end;

procedure TMigrations.OnRun(const AModules: IcbsModuleManager);
begin
  var LGraph := BuildReverseGraph(AModules);
  var LVisited := CreateVisitedList;
  try
    DFSExec('cbsSystem', LGraph, AModules, LVisited);
  finally
    LGraph := nil;
    LVisited := nil;
  end;
end;

procedure TMigrations.Run(const AModules: IcbsModuleManager);
begin
  BeforeRun(AModules);
  OnRun(AModules);
end;

end.
