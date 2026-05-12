unit Country.Inf.Repositories.CountryCodeRepository;

interface

uses
{PROJECT}
  Country.Inf.Contracts.Repositories.CountryCodeRepository,
  Country.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TCountryCodeRepository = class(TRepository<TCountryCodeEntity>, ICountryCodeRepository)
  public
    function Find(const ACodeType: string; const ACode: string): TCountryCodeEntity; overload;
    function Find(const ACodeType: string; const ACountryId: TGuid): TCountryCodeEntity; overload;
    function FindByCountryId(const ACountryId: TGuid): IList<TCountryCodeEntity>;
  end;

implementation

{ TCountryCodeRepository }

function TCountryCodeRepository.Find(const ACodeType: string; const ACode: string): TCountryCodeEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('CodeType', ACodeType)).Add(Restrictions.Eq('Code', ACode)));
end;

function TCountryCodeRepository.Find(const ACodeType: string; const ACountryId: TGuid): TCountryCodeEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('CodeType', ACodeType)).Add(Restrictions.Eq('CountryId', ToValue(ACountryId))));
end;

function TCountryCodeRepository.FindByCountryId(const ACountryId: TGuid): IList<TCountryCodeEntity>;
begin
  Result := ICriteria.Add(Restrictions.Eq('CountryId', ToValue(ACountryId))).ToList;
end;

initialization
begin
  RegisterRepository(ICountryCodeRepository, TCountryCodeRepository);
end;

end.
