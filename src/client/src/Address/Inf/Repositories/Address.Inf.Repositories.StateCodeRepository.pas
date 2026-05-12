unit Address.Inf.Repositories.StateCodeRepository;

interface

uses
{PROJECT}
  Address.Inf.Contracts.Repositories.StateCodeRepository,
  Address.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TStateCodeRepository = class(TRepository<TStateCodeEntity>, IStateCodeRepository)
  public
    function Find(const ACodeType: string; const ACode: string): TStateCodeEntity; overload;
    function Find(const ACodeType: string; const AStateId: TGuid): TStateCodeEntity; overload;
    function FindByStateId(const AStateId: TGuid): IList<TStateCodeEntity>;
  end;

implementation

{ TStateCodeRepository }

function TStateCodeRepository.Find(const ACodeType, ACode: string): TStateCodeEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('CodeType', ACodeType)).Add(Restrictions.Eq('Code', ACode)));
end;

function TStateCodeRepository.Find(const ACodeType: string; const AStateId: TGuid): TStateCodeEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('CodeType', ACodeType)).Add(Restrictions.Eq('StateId', ToValue(AStateId))));
end;

function TStateCodeRepository.FindByStateId(const AStateId: TGuid): IList<TStateCodeEntity>;
begin
  Result := ICriteria.Add(Restrictions.Eq('StateId', ToValue(AStateId))).ToList;
end;

initialization
begin
  RegisterRepository(IStateCodeRepository, TStateCodeRepository);
end;

end.



