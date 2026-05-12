unit Telecom.Inf.Repositories.AreaCodeRepository;

interface

uses
{PROJECT}
  Shared.Inf.Repositories.Repository,
  Telecom.Inf.Contracts.Repositories.AreaCodeRepository,
  Telecom.Inf.Entities,
{SPRING}
  Spring.Collections;

type
  TAreaCodeRepository = class(TRepository<TAreaCodeEntity>, IAreaCodeRepository)
  public
    function Find(const AId: TGuid): TAreaCodeEntity; overload;
    function Find(const AAreaCode: string; const AStateId: TGuid): TAreaCodeEntity; overload;
    function FindByStateId(const AStateId: TGuid): IList<TAreaCodeEntity>;
  end;

implementation

{ TAreaCodeRepository }

function TAreaCodeRepository.Find(const AId: TGuid): TAreaCodeEntity;
begin
  Result := inherited Find(AId);
end;

function TAreaCodeRepository.Find(const AAreaCode: string; const AStateId: TGuid): TAreaCodeEntity;
begin
  Result := FirstOrDefault(ICriteria.Add(Restrictions.Eq('AreaCode', AAreaCode)).Add(Restrictions.Eq('StateId', ToValue(AStateId))));
end;

function TAreaCodeRepository.FindByStateId(const AStateId: TGuid): IList<TAreaCodeEntity>;
begin
  Result := ICriteria.Add(Restrictions.Eq('StateId', ToValue(AStateId))).ToList;
end;

initialization
begin
  RegisterRepository(IAreaCodeRepository, TAreaCodeRepository);
end;

end.
