unit cbsSystem.Support.Utils;

interface

uses
{IDE}
  System.TypInfo;

  function GetCpfOrCnpfMask(const AValue: string): string;
  function GetInterfaceTypeInfoByGUID(const abstract: TGuid): PTypeInfo;
  function GetOnlyNumbers(const AValue: string): string;
  function GetTypInfo(const abstract: TGuid): PTypeInfo;

implementation

uses
{IDE}
  System.Character,
  System.Rtti,
  System.SysUtils;

function GetCpfOrCnpfMask(const AValue: string): string;
begin
  // Remove qualquer caractere não numérico (mantém só os números)
  var LValue := GetOnlyNumbers(AValue);
  // Aplica a máscara dinamicamente
  case Length(LValue) of
    4..6:
      begin
        // Formato CPF: xxx.XXX
        Result := Format('%s.%s', [Copy(LValue, 1, 3), Copy(LValue, 4, 3)]);
      end;
    7..9:
      begin
        // Formato CPF: xxx.xxx.XXX
        Result := Format('%s.%s.%s', [Copy(LValue, 1, 3), Copy(LValue, 4, 3), Copy(LValue, 7, 3)]);
      end;
    10..11:
      begin
        // Formato CPF: xxx.xxx.xxx-XX
        Result := Format('%s.%s.%s-%s', [Copy(LValue, 1, 3), Copy(LValue, 4, 3), Copy(LValue, 7, 3), Copy(LValue, 10, 2)]);
      end;
    12:
      begin
        // Formato CNPJ: xx.xxx.xxx/XXXX
        Result := Format('%s.%s.%s/%s', [Copy(LValue, 1, 2), Copy(LValue, 3, 3), Copy(LValue, 6, 3), Copy(LValue, 9, 4)]);
      end;
    13..14:
      begin
        // Formato CNPJ: xx.xxx.xxx/xxxx-XX
        Result := Format('%s.%s.%s/%s-%s', [Copy(LValue, 1, 2), Copy(LValue, 3, 3), Copy(LValue, 6, 3), Copy(LValue, 9, 4), Copy(LValue, 13, 2)]);
      end;
    else
      begin
        // Nenhuma formatação especial, apenas números
        Result := LValue;
      end;
  end;
end;

function GetInterfaceTypeInfoByGUID(const abstract: TGuid): PTypeInfo;
begin
  var LContext := TRttiContext.Create;
  try
    for var LItemType in LContext.GetTypes do
    begin
      if (LItemType is TRTTIInterfaceType) and
        IsEqualGUID(TRTTIInterfaceType(LItemType).GUID, abstract) then
      begin
        Exit(TRTTIInterfaceType(LItemType).Handle);
      end;
    end;
    Result := nil;
  finally
    LContext.Free;
  end;
end;

function GetOnlyNumbers(const AValue: string): string;
begin
  for var I := 1 to Length(AValue) do if
    AValue[I].IsDigit then
  begin
    Result := Result + AValue[i];
  end;
end;

function GetTypInfo(const abstract: TGuid): PTypeInfo;
begin
  Result := GetInterfaceTypeInfoByGUID(abstract);
end;

end.
