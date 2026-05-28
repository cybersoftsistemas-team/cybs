unit cbsSystem.DatabaseConfig;

interface

uses
{IDE}
  Data.DB,
  FireDAC.Comp.Client,
{PROJECT}
  cbsSystem.Contracts.DatabaseConfig,
  cbsSystem.Contracts.DataStorage;

type
  TDatabaseConfig = class(TInterfacedObject, IDatabaseConfig)
  private
    FDatabase: TFDMemTable;
    FDatabaseConnectionName: TStringField;
    FDatabaseConnectionString: TStringField;
    FDatabaseId: TGuidField;
    FDataStorage: IDataStorage;
    FLoading: Boolean;
    function GetConnectionName: string;
    function GetConnectionString: string;
    function GetId: TGuid;
    procedure AddOrEdit;
    procedure DatabaseAfterOpen(DataSet: TDataSet);
    procedure DatabaseAfterPost(DataSet: TDataSet);
    procedure SaveDatabaseData;
    procedure SetConnectionName(const AValue: string);
    procedure SetConnectionString(const AValue: string);
    procedure SetDatabaseFields;
    procedure SetId(const AValue: TGuid);
  public
    constructor Create;
    destructor Destroy; override;
    function Exists: Boolean;
    procedure ApplyUpdates;
    procedure CancelUpdate;
    procedure Clear;
    property ConnectionName: string read GetConnectionName write SetConnectionName;
    property ConnectionString: string read GetConnectionString write SetConnectionString;
    property Id: TGuid read GetId write SetId;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Support.Container,
  cbsSystem.Support.DataSet.Extensions;

const
  CST_FILENAME = 'database.dat';
  CST_KEY      = '{EC5880D8-82F9-4CFC-8865-3B4D43792E2E}';

{ TDatabaseConfig }

constructor TDatabaseConfig.Create;
begin
  inherited Create;
  FDataStorage := App.Make<IDataStorage>;
  FDatabase := TFDMemTable.Create(nil);
  FDatabase.AfterOpen := DatabaseAfterOpen;
  FDatabase.AfterPost := DatabaseAfterPost;
  SetDatabaseFields;
  FDatabase.CreateDataSet;
end;

destructor TDatabaseConfig.Destroy;
begin
  FDataStorage := nil;
  FreeAndNil(FDatabaseId);
  FreeAndNil(FDatabaseConnectionString);
  FreeAndNil(FDatabase);
  inherited;
end;

function TDatabaseConfig.Exists: Boolean;
begin
  Result := not FDatabaseId.IsNull and not FDatabaseConnectionString.IsNull;
end;

procedure TDatabaseConfig.AddOrEdit;
begin
  if FDatabase.State not in dsEditModes then
  begin
    FDatabase.Edit;
  end;
end;

procedure TDatabaseConfig.ApplyUpdates;
begin
  if FDatabase.State in dsEditModes then
  begin
    FDatabase.Post;
  end;
end;

procedure TDatabaseConfig.CancelUpdate;
begin
  if FDatabase.State in dsEditModes then
  begin
    FDatabase.Cancel;
  end;
end;

procedure TDatabaseConfig.Clear;
begin
  FDatabase.EmptyDataSet;
  SaveDatabaseData;
end;

procedure TDatabaseConfig.DatabaseAfterOpen(DataSet: TDataSet);
begin
  if not FLoading then
  begin
    FLoading := True;
    try
      FDatabase.LoadData(CST_KEY, FDataStorage.Load(CST_FILENAME));
    finally
      FLoading := False;
    end;
  end;
end;

procedure TDatabaseConfig.DatabaseAfterPost(DataSet: TDataSet);
begin
  SaveDatabaseData;
end;

//procedure TDatabaseConfig.ExecuteMigrations;
//begin
//  if IsPossibleExecuteMigrations then
//  begin
//    try
//      BeforeExecuteMigrations;
//      OnExecuteMigrations;
//    except
//      raise;
//    end;
//  end;
//end;

function TDatabaseConfig.GetConnectionName: string;
begin
  Result := FDatabaseConnectionName.AsString;
end;

function TDatabaseConfig.GetConnectionString: string;
begin
  Result := FDatabaseConnectionString.AsString;
end;

function TDatabaseConfig.GetId: TGuid;
begin
  Result := FDatabaseId.AsGuid;
end;

procedure TDatabaseConfig.SaveDatabaseData;
begin
  FDatabase.SaveData(CST_KEY, CST_FILENAME, csmServerSide);
end;

procedure TDatabaseConfig.SetConnectionName(const AValue: string);
begin
  AddOrEdit;
  FDatabaseConnectionName.AsString := AValue;
end;

procedure TDatabaseConfig.SetConnectionString(const AValue: string);
begin
  AddOrEdit;
  FDatabaseConnectionString.AsString := AValue;
end;

procedure TDatabaseConfig.SetDatabaseFields;
begin
  // DatabaseId
  FDatabaseId := TGuidField.Create(nil);
  FDatabaseId.FieldName := 'Id';
  FDatabaseId.Name := 'DatabaseId';
  FDatabaseId.Size := 38;
  FDatabaseId.DataSet := FDatabase;
  // DatabaseConnectionName
  FDatabaseConnectionName := TStringField.Create(nil);
  FDatabaseConnectionName.FieldName := 'ConnectionName';
  FDatabaseConnectionName.Name := 'DatabaseConnectionName';
  FDatabaseConnectionName.Size := 255;
  FDatabaseConnectionName.DataSet := FDatabase;
  // DatabaseConnectionString
  FDatabaseConnectionString := TStringField.Create(nil);
  FDatabaseConnectionString.FieldName := 'ConnectionString';
  FDatabaseConnectionString.Name := 'DatabaseConnectionString';
  FDatabaseConnectionString.Size := 255;
  FDatabaseConnectionString.DataSet := FDatabase;
end;

procedure TDatabaseConfig.SetId(const AValue: TGuid);
begin
  AddOrEdit;
  FDatabaseId.AsGuid := AValue;
end;

end.
