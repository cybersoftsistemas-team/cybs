unit cbsUAuth.inf.Services.PasswordHasher;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsUAuth.dom.Contracts.Services.PasswordHasher;

type
  TPasswordHasher = class(TInterfacedObject, IPasswordHasher)
  private
    function PBKDF2_HMAC_SHA256(const APassword: TBytes; const ASalt: TBytes; AIterations, ADKLen: Integer): TBytes;
    function SecureCompare(const A, B: TBytes): Boolean;
  public
    function GenerateSalt: TBytes;
    function Hash(const APassword: string; const ASalt: TBytes; AIterations: Integer): TBytes;
    function Verify(const APassword: string; const AHash, ASalt: TBytes; AIterations: Integer): Boolean;
  end;

implementation

uses
{IDE}
  System.Hash,
  System.Math,
  Winapi.Windows;

const
  BCRYPT_USE_SYSTEM_PREFERRED_RNG = $00000002;
  SIZE = 32;

function BCryptGenRandom(hAlgorithm: Pointer; pbBuffer: PUCHAR; cbBuffer: ULONG; dwFlags: ULONG): LongInt; stdcall; external 'bcrypt.dll';

{ TPasswordHasher }

function TPasswordHasher.GenerateSalt: TBytes;
begin
  SetLength(Result, SIZE);
  if BCryptGenRandom(nil, @Result[0], Length(Result), BCRYPT_USE_SYSTEM_PREFERRED_RNG) <> 0 then
  begin
    raise Exception.Create('Erro ao gerar salt');
  end;
end;

function TPasswordHasher.Hash(const APassword: string; const ASalt: TBytes; AIterations: Integer): TBytes;
begin
  Result := PBKDF2_HMAC_SHA256(
    TEncoding.UTF8.GetBytes(APassword),
    ASalt,
    AIterations,
    SIZE
  );
end;

function TPasswordHasher.PBKDF2_HMAC_SHA256(const APassword, ASalt: TBytes; AIterations, ADKLen: Integer): TBytes;
begin
  // número de blocos necessários
  var LBlockCount := Ceil(ADKLen / 32); // 32 = SHA256 output
  SetLength(Result, LBlockCount * 32);
  var LPos := 0;
  for var I := 1 to LBlockCount do
  begin
    var LBlockIndex: TBytes;
    // INT_32_BE(i)
    SetLength(LBlockIndex, 4);
    LBlockIndex[0] := (I shr 24) and $FF;
    LBlockIndex[1] := (I shr 16) and $FF;
    LBlockIndex[2] := (I shr 8) and $FF;
    LBlockIndex[3] := I and $FF;
    // U1 = HMAC(password, salt + blockIndex)
    var LU := THashSHA2.GetHMACAsBytes(ASalt + LBlockIndex, APassword);
    var LT := Copy(LU);
    // U2...Uc
    for var J := 2 to AIterations do
    begin
      LU := THashSHA2.GetHMACAsBytes(LU, APassword);
      for var K := 0 to High(LT) do
      begin
        LT[K] := LT[K] xor LU[K];
      end;
    end;
    // copia para resultado
    Move(LT[0], Result[LPos], Length(LT));
    Inc(LPos, Length(LT));
  end;
  SetLength(Result, ADKLen);
end;

function TPasswordHasher.SecureCompare(const A, B: TBytes): Boolean;
begin
  if Length(A) <> Length(B) then Exit(False);
  var LDiff: Byte := 0;
  for var I := 0 to High(A) do
  begin
    LDiff := LDiff or (A[I] xor B[I]);
  end;
  Result := LDiff = 0;
end;

function TPasswordHasher.Verify(const APassword: string; const AHash, ASalt: TBytes; AIterations: Integer): Boolean;
begin
  Result := SecureCompare(Hash(APassword, ASalt, AIterations), AHash);
end;

end.
