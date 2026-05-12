unit Country.Inf.Contracts.Repositories.CountryCodeRepository;

interface

uses
{PROJECT}
  Country.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  ICountryCodeRepository = interface(IRepository<TCountryCodeEntity>)
    ['{6A9BA18F-0A76-4EEA-94B8-97DCF040230F}']
    function Find(const ACodeType: string; const ACode: string): TCountryCodeEntity; overload;
    function Find(const ACodeType: string; const ACountryId: TGuid): TCountryCodeEntity; overload;
    function FindByCountryId(const ACountryId: TGuid): IList<TCountryCodeEntity>;
  end;

implementation

end.
