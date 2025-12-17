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
    FDatabase: TFDMemTable;
    FDatabaseConnectionName: TStringField;
    FDatabaseConnectionString: TStringField;
    FDatabaseId: TGuidField;
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
  protected
    function IsPossibleExecuteMigrations: Boolean; virtual;
    procedure BeforeExecuteMigrations; virtual;
    procedure OnExecuteMigrations; virtual;
  public
    constructor Create(const AOwner: IServerModule);
    destructor Destroy; override;
    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure Clear;
    procedure EndUpdate;
    procedure ExecuteMigrations;
    property ConnectionName: string read GetConnectionName write SetConnectionName;
    property ConnectionString: string read GetConnectionString write SetConnectionString;
    property Id: TGuid read GetId write SetId;
  end;

implementation

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Support.DataSet.Extensions;

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
  FreeAndNil(FDatabaseId);
  FreeAndNil(FDatabaseConnectionString);
  FreeAndNil(FDatabase);
  inherited;
end;

procedure TcbsDatabase.BeforeExecuteMigrations;
begin
  // This method can be overwritten by inherited classes.
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
  if IsPossibleExecuteMigrations then
  begin
    BeforeExecuteMigrations;
    OnExecuteMigrations;
  end;
end;

function TcbsDatabase.GetConnectionName: string;
begin
  Result := FDatabaseConnectionName.AsString;
end;

function TcbsDatabase.GetConnectionString: string;
begin
  Result := FDatabaseConnectionString.AsString;
end;

function TcbsDatabase.GetId: TGuid;
begin
  Result := FDatabaseId.AsGuid;
end;

function TcbsDatabase.IsPossibleExecuteMigrations: Boolean;
begin
  Result := not FDatabaseId.IsNull and not FDatabaseConnectionString.IsNull;
end;

procedure TcbsDatabase.OnExecuteMigrations;
begin
  // This method can be overwritten by inherited classes.
end;

procedure TcbsDatabase.SaveDatabaseData;
begin
  FDatabase.SaveData(CST_KEY, CST_FILENAME, csmServerSide);
end;

procedure TcbsDatabase.SetConnectionName(const AValue: string);
begin
  if FDatabase.State in dsEditModes then
  begin
    FDatabaseConnectionName.AsString := AValue;
  end;
end;

procedure TcbsDatabase.SetConnectionString(const AValue: string);
begin
  if FDatabase.State in dsEditModes then
  begin
    FDatabaseConnectionString.AsString := AValue;
  end;
end;

procedure TcbsDatabase.SetDatabaseFields;
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

procedure TcbsDatabase.SetId(const AValue: TGuid);
begin
  if FDatabase.State in dsEditModes then
  begin
    FDatabaseId.AsGuid := AValue;
  end;
end;

end.
