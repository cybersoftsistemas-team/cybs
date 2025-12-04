unit cbsSystem.Support.DataSet.Extensions;

interface

uses
{IDE}
  Data.DB,
  FireDAC.Comp.Client,
  System.SysUtils;

type
  TcbsStorageMode = (
    csmClientSide,
    csmServerSide
  );

  TFDMemTableExtensions = class helper for TFDMemTable
  private
    class var FAfterEmptyDataSet: TDataSetNotifyEvent;
    function Compress(const AValue: string): TBytes;
    function Decompress(const ABytes: TBytes): string;
    function Decrypt(const AData, APassword: string): string;
    function Encrypt(const AData, APassword: string): string;
    function StreamToBase64: string;
    procedure Base64ToStream(const AValue: string);
  public
    class property AfterEmptyDataSet: TDataSetNotifyEvent read FAfterEmptyDataSet write FAfterEmptyDataSet;
    procedure EmptyDataSet;
    procedure LoadData(const AKey, AData: string);
    procedure SaveData(const AKey, AFile: string; const AStorageMode: TcbsStorageMode = csmClientSide);
  end;

implementation

uses
{IDE}
  FireDAC.Stan.Intf,
  System.Classes,
  System.NetEncoding,
  System.ZLib,
  uniGUIApplication,
{PROJECT}
  cbsSystem.Support.ServerModule;

{ TFDMemTableExtensions }

function TFDMemTableExtensions.Compress(const AValue: string): TBytes;
begin
  var ms := TMemoryStream.Create;
  var ss := TStringStream.Create(AValue, TEncoding.UTF8);
  try
    var zs := TZCompressionStream.Create(ms);
    try
      zs.CopyFrom(ss, ss.Size);
    finally
      zs.Free;
    end;
    SetLength(Result, ms.Size);
    Move(ms.Memory^, Result[0], ms.Size);
  finally
    ms.Free;
    ss.Free;
  end;
end;

function TFDMemTableExtensions.Decompress(const ABytes: TBytes): string;
begin
  var ms := TMemoryStream.Create;
  var ss := TStringStream.Create('', TEncoding.UTF8);
  try
    ms.Write(ABytes[0], Length(ABytes));
    ms.Position := 0;
    var uz := TZDecompressionStream.Create(ms);
    try
      ss.CopyFrom(uz, 0);
      Result := ss.DataString;
    finally
      uz.Free;
    end;
  finally
    ms.Free;
    ss.Free;
  end;
end;

function TFDMemTableExtensions.Decrypt(const AData, APassword: string): string;
begin
  if AData.Trim.IsEmpty or
    SameText(AData.Trim, 'null') or
    SameText(AData.Trim, 'undefined') then
  begin
    Exit('');
  end;
  var LPwd := TEncoding.UTF8.GetBytes(APassword);
  var LBytes := TNetEncoding.Base64.DecodeStringToBytes(AData);
  for var I := 0 to High(LBytes) do
  begin
    LBytes[I] := LBytes[I] xor LPwd[I mod Length(LPwd)];
  end;
  Result := Decompress(LBytes);
end;

procedure TFDMemTableExtensions.EmptyDataSet;
begin
  inherited EmptyDataSet;
  if Assigned(FAfterEmptyDataSet) then
  begin
    FAfterEmptyDataSet(Self);
  end;
end;

function TFDMemTableExtensions.Encrypt(const AData, APassword: string): string;
begin
  var LBytes := Compress(AData);
  var LPwd := TEncoding.UTF8.GetBytes(APassword);
  for var I := 0 to High(LBytes) do
  begin
    LBytes[I] := LBytes[I] xor LPwd[I mod Length(LPwd)];
  end;
  Result := TNetEncoding.Base64.EncodeBytesToString(LBytes);
end;

function TFDMemTableExtensions.StreamToBase64: string;
begin
  var ms := TMemoryStream.Create;
  try
    Self.ResourceOptions.Persistent := False;
    Self.SaveToStream(ms, sfBinary);
    ms.Position := 0;
    Result := TNetEncoding.Base64.EncodeBytesToString(ms.Memory, ms.Size);
  finally
    ms.Free;
  end;
end;

procedure TFDMemTableExtensions.Base64ToStream(const AValue: string);
begin
  if AValue.Trim.IsEmpty or
    SameText(AValue.Trim, 'null') or
    SameText(AValue.Trim, 'undefined') then
  begin
    Exit;
  end;
  var Lms := TMemoryStream.Create;
  var LBytes := TNetEncoding.Base64.DecodeStringToBytes(AValue);
  try
    Lms.Write(LBytes, Length(LBytes));
    Lms.Position := 0;
    Self.LoadFromStream(Lms, sfBinary);
  finally
    Lms.Free;
  end;
end;

procedure TFDMemTableExtensions.LoadData(const AKey, AData: string);
begin
  Base64ToStream(Decrypt(AData, AKey));
end;

procedure TFDMemTableExtensions.SaveData(const AKey, AFile: string; const AStorageMode: TcbsStorageMode);
begin
  if Self.State in dsEditModes then
  begin
    Self.Post;
  end;
  var LEnc := Encrypt(StreamToBase64, AKey).Replace(#13, '').Replace(#10, '');
  if AStorageMode = csmServerSide then
  begin
    ServerModule.DataStorage.Save(AFile, LEnc);
  end
  else if AStorageMode = csmClientSide then
  begin
    UniSession.AddJS(Format('window.DataStorage.save("%s","%s");', [AFile, LEnc]));
  end;
end;

end.
