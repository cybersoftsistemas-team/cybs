unit Country.Inf.Contracts.Repositories.CountryRepository;

interface

uses
{PROJECT}
  Country.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository;

type
  ICountryRepository = interface(IRepository<TCountryEntity>)
    ['{686A26F9-F743-4C14-84EE-B3C9247DA10E}']
    function Find(const AId: TGuid): TCountryEntity; overload;
    function Find(const AName: string): TCountryEntity; overload;
  end;

implementation

end.
