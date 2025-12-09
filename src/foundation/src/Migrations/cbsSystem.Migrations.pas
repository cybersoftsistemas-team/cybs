unit cbsSystem.Migrations;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Migrations,
  cbsSystem.Contracts.Module.Manager;

type
  TMigrations = class(TInterfacedObject, IMigrations)
  private
    procedure BeforeRun(const AModules: IModuleManager);
    function BuildReverseGraph(const AModules: IModuleManager): IGraphList;
    procedure CheckPacketCycles(const AModules: IModuleManager);
    procedure DFSExec(const AModuleName: string; const AGraph: IGraphList; const AModules: IModuleManager; const AVisited: IVisitedList);
    procedure OnRun(const AModules: IModuleManager);
    procedure RegisterSystemMigrations;
    procedure RunMigrations(const AModules: IModuleManager);
    procedure RunSystenMigrations;
  public
    procedure Run(const AModules: IModuleManager);
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  _2025_12_08_00000001_create_auxiliary_data_schema,
  _2025_12_08_00000005_create_auxiliary_data_categories_table,
  cbsMigrations.Support.Migration,
  cbsSystem.Infrastructure.SystemDbModule,
  cbsSystem.Migrations.DbSystemContext,
  cbsSystem.Module.Manager.CycleInfo;

procedure TMigrations.BeforeRun(const AModules: IModuleManager);
begin
  RegisterSystemMigrations;
  CheckPacketCycles(AModules);
end;

{ TMigrations }

function TMigrations.BuildReverseGraph(const AModules: IModuleManager): IGraphList;
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

procedure TMigrations.CheckPacketCycles(const AModules: IModuleManager);
begin
  if Assigned(AModules) then
  begin
    var LCycle := DetectCircularDependencies(AModules);
    if LCycle.HasCycle then
    begin
      raise Exception.Create('Dependências circulares detectadas!' +
        sLineBreak + String.Join(' → ', LCycle.Path));
    end;
  end;
end;

procedure TMigrations.DFSExec(const AModuleName: string; const AGraph: IGraphList; const AModules: IModuleManager; const AVisited: IVisitedList);
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

procedure TMigrations.OnRun(const AModules: IModuleManager);
begin
  RunSystenMigrations;
  RunMigrations(AModules);
end;

procedure TMigrations.RegisterSystemMigrations;
begin
  RegisterMigration(TDbSystemContext, CreateAuxiliaryDataSchema);
  RegisterMigration(TDbSystemContext, CreateAuxiliaryDataCategoriesTable);
end;

procedure TMigrations.Run(const AModules: IModuleManager);
begin
  BeforeRun(AModules);
  OnRun(AModules);
end;

procedure TMigrations.RunMigrations(const AModules: IModuleManager);
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

procedure TMigrations.RunSystenMigrations;
begin
  var LDbContext := TDbSystemContext.Create;
  try
    LDbContext.Connection.StartTransaction;
    try
      var LdamSystemDb := TdamSystemDb.Create(nil);
      try
        LDbContext.UpdateDatabase(LdamSystemDb.RunSeed);
      finally
        FreeAndNil(LdamSystemDb);
      end;
    except
      on E: Exception do
      begin
        LDbContext.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
    LDbContext.Connection.Commit;
  finally
    FreeAndNil(LDbContext);
  end;
end;

end.
