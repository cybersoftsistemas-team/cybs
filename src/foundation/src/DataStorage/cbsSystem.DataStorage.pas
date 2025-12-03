unit cbsSystem.DataStorage;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.DataStorage,
  cbsSystem.Contracts.Module.ServerModule;

type
  TcbsDataStorage = class(TInterfacedObject, IcbsDataStorage)
  private
    FFileContent: string;
    FFileName: TFileName;
    FOwner: IServerModule;
    function GetConfigPath: string;
    procedure BeforeLoad(const AFileName: TFileName);
    procedure BeforeSave(const AFileName: TFileName);
    procedure OnSave(const AData: string);
  public
    constructor Create(const AOwner: IServerModule);
    function Load(const AFileName: string): string;
    procedure Save(const AFileName, AData: string);
  end;

implementation

uses
{IDE}
  System.Classes,
  System.IOUtils;

{ TcbsDataStorage }

constructor TcbsDataStorage.Create(const AOwner: IServerModule);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TcbsDataStorage.GetConfigPath: string;
begin
  Result := FOwner.ProgramDataPath;
end;

function TcbsDataStorage.Load(const AFileName: string): string;
begin
  BeforeLoad(AFileName);
  Result := FFileContent;
end;

procedure TcbsDataStorage.BeforeLoad(const AFileName: TFileName);
begin
  FFileContent := '';
  FFileName := TPath.Combine(GetConfigPath, AFileName);
  if not FileExists(FFileName) then
  begin
    Exit;
  end;
  var LStrStream := TStringStream.Create('');
  LStrStream.LoadFromFile(FFileName);
  FFileContent := LStrStream.DataString;
end;

procedure TcbsDataStorage.BeforeSave(const AFileName: TFileName);
begin
  FFileName := TPath.Combine(GetConfigPath, AFileName);
end;

procedure TcbsDataStorage.OnSave(const AData: string);
begin
  var LStrStream := TStringStream.Create(AData);
  try
    LStrStream.Position := 0;
    LStrStream.SaveToFile(FFileName);
  finally
    FreeAndNil(LStrStream);
  end;
end;

procedure TcbsDataStorage.Save(const AFileName, AData: string);
begin
  BeforeSave(AFileName);
  OnSave(AData);
end;

end.
