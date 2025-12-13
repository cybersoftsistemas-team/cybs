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
  cbsMigrations.Support.Migration,
  cbsSystem.Infrastructure.SystemDbModule,
  cbsSystem.Migrations.DbSystemContext,
  cbsSystem.Module.Manager.CycleInfo,
  // Migrations...
  _2025_12_08_00000001_create_auxiliary_data_schema,
  _2025_12_08_00000005_create_auxiliary_data_categories_table,
  _2025_12_08_00000010_create_address_schema,
  _2025_12_08_00000015_create_address_countries_table,
  _2025_12_08_00000020_create_address_states_table,
  _2025_12_08_00000025_create_address_cities_table,
  _2025_12_08_00000030_create_address_neighborhoods_table,
  _2025_12_08_00000035_create_address_streets_table,
  _2025_12_08_00000040_create_address_streettypes_table,
  _2025_12_08_00000045_create_address_addresses_table,
  _2025_12_08_00000050_create_person_schema,
  _2025_12_08_00000055_create_person_nationalities_table,
  _2025_12_08_00000060_create_person_persons_table,
  _2025_12_08_00000070_create_person_naturals_table,
  _2025_12_08_00000065_create_person_legals_table,
  _2025_12_08_00000075_create_person_addresses_table,
  _2025_12_08_00000075_create_person_emails_table,
  _2025_12_08_00000075_create_person_phones_table;

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

procedure TMigrations.OnRun(const AModules: IModuleManager);
begin
  RunSystenMigrations;
  RunMigrations(AModules);
end;

procedure TMigrations.RegisterSystemMigrations;
begin
  RegisterMigration(TDbSystemContext, CreateAuxiliaryDataSchema);
  RegisterMigration(TDbSystemContext, CreateAuxiliaryDataCategoriesTable);
  RegisterMigration(TDbSystemContext, CreateAddressSchema);
  RegisterMigration(TDbSystemContext, CreateAddressCountriesTable);
  RegisterMigration(TDbSystemContext, CreateAddressStatesTable);
  RegisterMigration(TDbSystemContext, CreateAddressCitiesTable);
  RegisterMigration(TDbSystemContext, CreateAddressNeighborhoodsTable);
  RegisterMigration(TDbSystemContext, CreateAddressStreetsTable);
  RegisterMigration(TDbSystemContext, CreateAddressStreetTypesTable);
  RegisterMigration(TDbSystemContext, CreateAddressAddressesTable);
  RegisterMigration(TDbSystemContext, CreatePersonSchema);
  RegisterMigration(TDbSystemContext, CreatePersonNationalitiesTable);
  RegisterMigration(TDbSystemContext, CreatePersonPersonsTable);
  RegisterMigration(TDbSystemContext, CreatePersonAddressesTable);
  RegisterMigration(TDbSystemContext, CreatePersonLegalsTable);
  RegisterMigration(TDbSystemContext, CreatePersonNaturalsTable);
  RegisterMigration(TDbSystemContext, CreatePersonEmailsTable);
  RegisterMigration(TDbSystemContext, CreatePersonPhonesTable);
end;

procedure TMigrations.RunSystenMigrations;
begin
  var damSysDb := TdamSystemDb.Create(nil);
  try
    damSysDb.Connection.StartTransaction;
    try
      var LDbContext := TDbSystemContext.Create;
      try
        LDbContext.Connection := damSysDb.Connection;
        LDbContext.UpdateDatabase(damSysDb.RunSeed);
      finally
        FreeAndNil(LDbContext);
      end;
    except
      on E: Exception do
      begin
        damSysDb.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
    damSysDb.Connection.Commit;
  finally
    FreeAndNil(damSysDb);
  end;
end;

end.
