unit cbsSystem.Database;

interface

uses
{IDE}
  Data.DB,
  FireDAC.Comp.Client,
{PROJECT}
  cbsSystem.Contracts.Database,
  cbsSystem.Contracts.Module.ServerModule;

type
  TcbsDatabase = class(TInterfacedObject, IcbsDatabase)
  private
    DatabaseId: TGuidField;
    DatabaseConnectionName: TStringField;
    DatabaseConnectionString: TStringField;
    FDatabase: TFDMemTable;
    FLoading: Boolean;
    FOwner: IServerModule;
    function GetConnectionName: string;
    function GetConnectionString: string;
    function GetId: TGuid;
    procedure DatabaseAfterOpen(DataSet: TDataSet);
    procedure DatabaseAfterPost(DataSet: TDataSet);
    procedure SaveDatabaseData;
    procedure SetConnectionName(const AValue: string);
    procedure SetConnectionString(const AValue: string);
    procedure SetDatabaseFields;
    procedure SetId(const AValue: TGuid);
  public
    constructor Create(const AOwner: IServerModule);
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure Clear;
    procedure CancelUpdate;
    procedure EndUpdate;
    procedure ExecuteMigrations;
    property Id: TGuid read GetId write SetId;
    property ConnectionName: string read GetConnectionName write SetConnectionName;
    property ConnectionString: string read GetConnectionString write SetConnectionString;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Support.DataSet.Extensions,
  cbsSystem.Support.Migrations,
  cbsSystem.Support.ModuleManager;

const
  CST_FILENAME = 'database.dat';
  CST_KEY      = '{EC5880D8-82F9-4CFC-8865-3B4D43792E2E}';

{ TcbsDatabase }

constructor TcbsDatabase.Create(const AOwner: IServerModule);
begin
  inherited Create;
  FOwner := AOwner;
  FDatabase := TFDMemTable.Create(nil);
  FDatabase.AfterOpen := DatabaseAfterOpen;
  FDatabase.AfterPost := DatabaseAfterPost;
  SetDatabaseFields;
  FDatabase.CreateDataSet;
end;

destructor TcbsDatabase.Destroy;
begin
  FreeAndNil(DatabaseId);
  FreeAndNil(DatabaseConnectionString);
  FreeAndNil(FDatabase);
  inherited;
end;

function TcbsDatabase.GetConnectionName: string;
begin
  Result := DatabaseConnectionName.AsString;
end;

function TcbsDatabase.GetConnectionString: string;
begin
  Result := DatabaseConnectionString.AsString;
end;

function TcbsDatabase.GetId: TGuid;
begin
  Result := DatabaseId.AsGuid;
end;

procedure TcbsDatabase.BeginUpdate;
begin
  if FDatabase.State not in dsEditModes then
  begin
    FDatabase.Edit;
  end;
end;

procedure TcbsDatabase.CancelUpdate;
begin
  if FDatabase.State in dsEditModes then
  begin
    FDatabase.Cancel;
  end;
end;

procedure TcbsDatabase.Clear;
begin
  FDatabase.EmptyDataSet;
  SaveDatabaseData;
end;

procedure TcbsDatabase.DatabaseAfterOpen(DataSet: TDataSet);
begin
  if not FLoading then
  begin
    FLoading := True;
    try
      FDatabase.LoadData(CST_KEY, FOwner.DataStorage.Load(CST_FILENAME));
    finally
      FLoading := False;
    end;
  end;
end;

procedure TcbsDatabase.DatabaseAfterPost(DataSet: TDataSet);
begin
  SaveDatabaseData;
end;

procedure TcbsDatabase.EndUpdate;
begin
  if FDatabase.State in dsEditModes then
  begin
    FDatabase.Post;
  end;
end;

procedure TcbsDatabase.ExecuteMigrations;
begin
  if not DatabaseId.IsNull and
    not DatabaseConnectionString.IsNull then
  begin
    Migrations.Run;
  end;
end;

procedure TcbsDatabase.SaveDatabaseData;
begin
  FDatabase.SaveData(CST_KEY, CST_FILENAME, csmServerSide);
end;

procedure TcbsDatabase.SetConnectionName(const AValue: string);
begin
  if FDatabase.State in dsEditModes then
  begin
    DatabaseConnectionName.AsString := AValue;
  end;
end;

procedure TcbsDatabase.SetConnectionString(const AValue: string);
begin
  if FDatabase.State in dsEditModes then
  begin
    DatabaseConnectionString.AsString := AValue;
  end;
end;

procedure TcbsDatabase.SetDatabaseFields;
begin
  // DatabaseId
  DatabaseId := TGuidField.Create(nil);
  DatabaseId.FieldName := 'Id';
  DatabaseId.Name := 'DatabaseId';
  DatabaseId.Size := 38;
  DatabaseId.DataSet := FDatabase;
  // DatabaseConnectionName
  DatabaseConnectionName := TStringField.Create(nil);
  DatabaseConnectionName.FieldName := 'ConnectionName';
  DatabaseConnectionName.Name := 'DatabaseConnectionName';
  DatabaseConnectionName.Size := 255;
  DatabaseConnectionName.DataSet := FDatabase;
  // DatabaseConnectionString
  DatabaseConnectionString := TStringField.Create(nil);
  DatabaseConnectionString.FieldName := 'ConnectionString';
  DatabaseConnectionString.Name := 'DatabaseConnectionString';
  DatabaseConnectionString.Size := 255;
  DatabaseConnectionString.DataSet := FDatabase;
end;

procedure TcbsDatabase.SetId(const AValue: TGuid);
begin
  if FDatabase.State in dsEditModes then
  begin
    DatabaseId.AsGuid := AValue;
  end;
end;

end.
