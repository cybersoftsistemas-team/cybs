unit cdsCliSrv.FDDataSet.Extensions;

interface

uses
{IDE}
  FireDAC.Comp.DataSet,
  System.SysUtils;

type
  TFDDataSetExtensions = class helper for TFDDataSet
  private
    function Compress(const S: string): TBytes;
    function Decompress(const B: TBytes): string;
    function Decrypt(const AData, APassword: string): string;
    function Encrypt(const AData, APassword: string): string;
    function StreamToBase64: string;
    procedure Base64ToStream(const AB64: string);
  public
    procedure LoadData(const AKey, AData: string);
    procedure SaveData(const AKey, AFile: string);
  end;

implementation

uses
{IDE}
  Data.DB,
  FireDAC.Stan.Intf,
  System.Classes,
  System.NetEncoding,
  System.ZLib,
  uniGUIApplication,
{PROJECT}
  cbsCliSrv.RunTime;

{ TFDDataSetExtensions }

function TFDDataSetExtensions.Compress(const S: string): TBytes;
begin
  var ss := TStringStream.Create(S, TEncoding.UTF8);
  var ms := TMemoryStream.Create;
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

function TFDDataSetExtensions.Decompress(const B: TBytes): string;
begin
  var ms := TMemoryStream.Create;
  var ss := TStringStream.Create('', TEncoding.UTF8);
  try
    ms.Write(B[0], Length(B));
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

function TFDDataSetExtensions.Decrypt(const AData, APassword: string): string;
begin
  if AData.Trim.IsEmpty or
    SameText(AData.Trim, 'null') or
    SameText(AData.Trim, 'undefined') then
  begin
    Exit('');
  end;
  var LBytes := TNetEncoding.Base64.DecodeStringToBytes(AData);
  var LPwd := TEncoding.UTF8.GetBytes(APassword);
  for var I := 0 to High(LBytes) do
  begin
    LBytes[I] := LBytes[I] xor LPwd[I mod Length(LPwd)];
  end;
  Result := Decompress(LBytes);
end;

function TFDDataSetExtensions.Encrypt(const AData, APassword: string): string;
begin
  var LBytes := Compress(AData);
  var LPwd := TEncoding.UTF8.GetBytes(APassword);
  for var I := 0 to High(LBytes) do
  begin
    LBytes[I] := LBytes[I] xor LPwd[I mod Length(LPwd)];
  end;
  Result := TNetEncoding.Base64.EncodeBytesToString(LBytes);
end;

function TFDDataSetExtensions.StreamToBase64: string;
begin
  var ms := TMemoryStream.Create;
  try
    Self.SaveToStream(ms, sfBinary);
    ms.Position := 0;
    Result := TNetEncoding.Base64.EncodeBytesToString(ms.Memory, ms.Size);
  finally
    ms.Free;
  end;
end;

procedure TFDDataSetExtensions.Base64ToStream(const AB64: string);
begin
  if AB64.Trim.IsEmpty or
    SameText(AB64.Trim, 'null') or
    SameText(AB64.Trim, 'undefined') then
  begin
    Exit;
  end;
  var LBytes := TNetEncoding.Base64.DecodeStringToBytes(AB64);
  var Lms := TMemoryStream.Create;
  try
    Lms.Write(LBytes, Length(LBytes));
    Lms.Position := 0;
    Self.LoadFromStream(Lms, sfBinary);
  finally
    Lms.Free;
  end;
end;

procedure TFDDataSetExtensions.LoadData(const AKey, AData: string);
begin
  var LB64 := Decrypt(AData, AKey);
  Base64ToStream(LB64);
end;

procedure TFDDataSetExtensions.SaveData(const AKey, AFile: string);
begin
  if Self.State in dsEditModes then
  begin
    Self.Post;
  end;
  var LB64 := StreamToBase64;
  var LEnc := Encrypt(LB64, AKey);
  if RunTime.IsElectron then
  begin
    // Salvar via Electron IPC
    UniSession.AddJS(
      'window.electronAPI.saveClientData(' +
      QuotedStr(AFile) + ', ' + QuotedStr(LEnc.Replace(#13, '').Replace(#10, '')) + ');'
    );
  end
  else
  begin
    // Salvar no localStorage
    UniSession.AddJS(
      'localStorage.setItem(' +
      QuotedStr(AFile) + ', ' + QuotedStr(LEnc.Replace(#13, '').Replace(#10, '')) + ');'
    );
  end;
end;

end.
