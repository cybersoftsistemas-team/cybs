unit cbsSystem.DataStorage;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Contracts.DataStorage;

type
  TDataStorage = class(TInterfacedObject, IDataStorage)
  private
    FFileContent: string;
    FFileName: TFileName;
    function GetConfigPath: string;
    function GetProgramDataConfigPath: string;
    procedure BeforeLoad(const AFileName: TFileName);
    procedure BeforeSave(const AFileName: TFileName);
    procedure OnSave(const AData: string);
  public
    function Load(const AFileName: string): string;
    procedure Save(const AFileName, AData: string);
  end;

implementation

uses
{IDE}
  System.Classes,
  System.IOUtils;

{ TDataStorage }

function TDataStorage.GetConfigPath: string;
begin
  Result := GetProgramDataConfigPath;
end;

function TDataStorage.GetProgramDataConfigPath: string;
begin
  Result := TPath.Combine(TPath.GetPublicPath, '.cybersoft', 'config');
  if not DirectoryExists(Result) then
  begin
    ForceDirectories(Result);
  end;
end;

function TDataStorage.Load(const AFileName: string): string;
begin
  BeforeLoad(AFileName);
  Result := FFileContent;
end;

procedure TDataStorage.BeforeLoad(const AFileName: TFileName);
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

procedure TDataStorage.BeforeSave(const AFileName: TFileName);
begin
  FFileName := TPath.Combine(GetConfigPath, AFileName);
end;

procedure TDataStorage.OnSave(const AData: string);
begin
  var LStrStream := TStringStream.Create(AData);
  try
    LStrStream.Position := 0;
    LStrStream.SaveToFile(FFileName);
  finally
    FreeAndNil(LStrStream);
  end;
end;

procedure TDataStorage.Save(const AFileName, AData: string);
begin
  BeforeSave(AFileName);
  OnSave(AData);
end;

end.
