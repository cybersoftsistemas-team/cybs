unit Address.Inf.Seeders.damDbSeed.Extensions;

interface

uses
{PROJECT}
  Address.Inf.Seeders.damDbSeed;

type
  TdamAddressDbSeedExtensions = class helper for TdamAddressDbSeed
  public
    procedure CreateState(const AId: TGuid; const AName: string; const AAcronym: string; const ACountryId: TGuid);
    procedure CreateStateCode(const ACodeType: string; const ACode: string; const AStateId: TGuid);
  end;

implementation

uses
{PROJECT}
  Address.Inf.Entities;

{ TdamAddressDbSeedExtensions }

procedure TdamAddressDbSeedExtensions.CreateState(const AId: TGuid; const AName, AAcronym: string; const ACountryId: TGuid);
begin
  var LEntity := StateRepository.Find(AId);
  try
    if not Assigned(LEntity) then
      LEntity := TStateEntity.Create;
    LEntity.Id := AId;
    LEntity.Name := AName;
    LEntity.Acronym := AAcronym;
    LEntity.CountryId := ACountryId;
    StateRepository.Save(LEntity);
  finally
    LEntity.Free;
  end;
end;

procedure TdamAddressDbSeedExtensions.CreateStateCode(const ACodeType, ACode: string; const AStateId: TGuid);
begin
  var LEntity := StateCodeRepository.Find(ACodeType, ACode);
  try
    if not Assigned(LEntity) then
    begin
      LEntity := TStateCodeEntity.Create;
      LEntity.CodeType := ACodeType;
      LEntity.Code := ACode;
      LEntity.StateId := AStateId;
      StateCodeRepository.Insert(LEntity);
    end;
  finally
    LEntity.Free;
  end;
end;

end.
