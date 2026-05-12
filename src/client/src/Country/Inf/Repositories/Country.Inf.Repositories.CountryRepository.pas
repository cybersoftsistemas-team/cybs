unit Country.Inf.Repositories.CountryRepository;

interface

uses
{PROJECT}
  Country.Inf.Contracts.Repositories.CountryRepository,
  Country.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TCountryRepository = class(TRepository<TCountryEntity>, ICountryRepository)
  public
    function Find(const AId: TGuid): TCountryEntity; overload;
    function Find(const AName: string): TCountryEntity; overload;
  end;

implementation

{ TCountryRepository }

function TCountryRepository.Find(const AId: TGuid): TCountryEntity;
begin
  Result := inherited Find(AId);
end;

function TCountryRepository.Find(const AName: string): TCountryEntity;
begin
  Result := inherited Find(AName);
end;

initialization
begin
  RegisterRepository(ICountryRepository, TCountryRepository);
end;

end.
