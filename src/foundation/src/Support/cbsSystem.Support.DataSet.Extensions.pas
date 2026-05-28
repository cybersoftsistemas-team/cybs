unit cbsSystem.Support.DataSet.Extensions;

interface

uses
{IDE}
  Data.DB,
  FireDAC.Comp.Client,
  System.JSON,
  System.SysUtils;

type
  TcbsStorageMode = (
    csmClientSide,
    csmServerSide
  );

  TFDMemTableExtensions = class helper for TFDMemTable
  private
    function Compress(const AValue: string): TBytes;
    function Decompress(const ABytes: TBytes): string;
    function Decrypt(const AData, APassword: string): string;
    function Encrypt(const AData, APassword: string): string;
    function StreamToBase64: string;
    function ToJSONObject: TJSONObject;
    procedure Base64ToStream(const AValue: string);
    procedure ToDataSet(const AJSON: string);
  public
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
  cbsSystem.Contracts.DataStorage,
  cbsSystem.Support.Container;

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
  var LJSonObject := ToJSONObject;
  try
    var ms := TStringStream.Create(LJSonObject.ToJSON, TEncoding.UTF8);
    try
      ms.Position := 0;
      Result := TNetEncoding.Base64.EncodeBytesToString(ms.Memory, ms.Size);
    finally
      ms.Free;
    end;
  finally
    LJSonObject.Free;
  end;
end;

function TFDMemTableExtensions.ToJSONObject: TJSONObject;
begin
  Result := TJSONObject.Create;
  for var LField in Self.Fields do
  begin
    case LField.DataType of
      ftBoolean:
        Result.AddPair(
          LField.FieldName,
          TJSONBool.Create(LField.AsBoolean)
        );
      ftSmallint,
      ftInteger,
      ftWord,
      ftLongWord,
      ftShortint,
      ftByte,
      ftLargeint,
      ftAutoInc:
        Result.AddPair(
          LField.FieldName,
          TJSONNumber.Create(LField.AsLargeInt)
        );
      ftFloat,
      ftCurrency,
      ftBCD,
      ftFMTBcd:
        Result.AddPair(
          LField.FieldName,
          TJSONNumber.Create(LField.AsFloat)
        );
    else
      Result.AddPair(
        LField.FieldName,
        LField.AsString
      );
    end;
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
  ToDataSet(TEncoding.UTF8.GetString(TNetEncoding.Base64.DecodeStringToBytes(AValue)));
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
    App.Make<IDataStorage>.Save(AFile, LEnc);
  end
  else if AStorageMode = csmClientSide then
  begin
    UniSession.AddJS(Format('window.DataStorage.save("%s","%s");', [AFile, LEnc]));
  end;
end;

procedure TFDMemTableExtensions.ToDataSet(const AJSON: string);
begin
  var LJSONObject := TJSONObject.ParseJSONValue(AJSON) as TJSONObject;
  try
    Self.DisableControls;
    try
      Self.EmptyDataSet;
      Self.Append;
      for var LPair in LJSONObject do
      begin
        var LField := Self.FindField(LPair.JsonString.Value);
        if not Assigned(LField) then
          Continue;
        if LPair.JsonValue is TJSONNull then
        begin
          LField.Clear;
          Continue;
        end;
        case LField.DataType of
          ftBoolean:
            LField.AsBoolean :=
              LPair.JsonValue.Value.ToBoolean;
          ftSmallint,
          ftInteger,
          ftWord,
          ftLongWord,
          ftShortint,
          ftByte,
          ftLargeint,
          ftAutoInc:
            LField.AsLargeInt :=
              StrToInt64Def(
                LPair.JsonValue.Value,
                0
              );
          ftFloat,
          ftCurrency,
          ftBCD,
          ftFMTBcd:
            LField.AsFloat :=
              StrToFloatDef(
                LPair.JsonValue.Value,
                0
              );
        else
          LField.AsString :=
            LPair.JsonValue.Value;
        end;
      end;
      Self.Post;
    finally
      Self.EnableControls;
    end;
  finally
    LJSONObject.Free;
  end;
end;

end.
