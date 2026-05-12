unit Address.Inf.Repositories.CityCodeRepository;

interface

uses
{PROJECT}
  Address.Inf.Contracts.Repositories.CityCodeRepository,
  Address.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TCityCodeRepository = class(TRepository<TCityCodeEntity>, ICityCodeRepository)
  public
    function Find(const ACodeType: string; const ACode: string): TCityCodeEntity; overload;
    function Find(const ACodeType: string; const ACityId: TGuid): TCityCodeEntity; overload;
    function FindByCityId(const ACityId: TGuid): IList<TCityCodeEntity>;
  end;

implementation

{ TCityCodeRepository }

function TCityCodeRepository.Find(const ACodeType, ACode: string): TCityCodeEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('CodeType', ACodeType)).Add(Restrictions.Eq('Code', ACode)));
end;

function TCityCodeRepository.Find(const ACodeType: string; const ACityId: TGuid): TCityCodeEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('CodeType', ACodeType)).Add(Restrictions.Eq('CityId', ToValue(ACityId))));
end;

function TCityCodeRepository.FindByCityId(const ACityId: TGuid): IList<TCityCodeEntity>;
begin
  Result := ICriteria.Add(Restrictions.Eq('CityId', ToValue(ACityId))).ToList;
end;

initialization
begin
  RegisterRepository(ICityCodeRepository, TCityCodeRepository);
end;

end.



