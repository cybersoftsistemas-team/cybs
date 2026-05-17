unit Country.Inf.Seeders.damDbSeed.Extensions;

interface

uses
{PROJECT}
  Country.Inf.Seeders.damDbSeed;

type
  TdamCountryDbSeedExtensions = class helper for TdamCountryDbSeed
  public
    procedure CreateCountry(const AId: TGuid; const AName: string; const ADialCode: string);
    procedure CreateCountryCode(const ACodeType: string; const ACode: string; const ACountryId: TGuid);
    procedure CreateNationality(const AName: string; const ACountryId: TGuid);
  end;

implementation

uses
{PROJECT}
  Country.Inf.Entities;

{ TdamCountryDbSeedExtensions }

procedure TdamCountryDbSeedExtensions.CreateCountry(const AId: TGuid; const AName, ADialCode: string);
begin
  var LEntity := CountryRepository.Find(AName);
  try
    if not Assigned(LEntity) then
      LEntity := TCountryEntity.Create;
    LEntity.Id := AId;
    LEntity.Name := AName;
    LEntity.DialCode := ADialCode;
    CountryRepository.Save(LEntity);
  finally
    LEntity.Free;
  end;
end;

procedure TdamCountryDbSeedExtensions.CreateCountryCode(const ACodeType, ACode: string; const ACountryId: TGuid);
begin
  var LEntity := CountryCodeRepository.Find(ACodeType, ACode);
  try
    if not Assigned(LEntity) then
    begin
      LEntity := TCountryCodeEntity.Create;
      LEntity.CodeType := ACodeType;
      LEntity.Code := ACode;
      LEntity.CountryId := ACountryId;
      CountryCodeRepository.Insert(LEntity);
    end;
  finally
    LEntity.Free;
  end;
end;

procedure TdamCountryDbSeedExtensions.CreateNationality(const AName: string; const ACountryId: TGuid);
begin
  var LEntity := NationalityRepository.Find(ACountryId);
  try
    if not Assigned(LEntity) then
      LEntity := TNationalityEntity.Create;
    LEntity.Id := ACountryId;
    LEntity.Name := AName;
    NationalityRepository.Save(LEntity);
  finally
    LEntity.Free;
  end;
end;

end.
