unit Domain.Inf.Repositories.DomainRepository;

interface

uses
{PROJECT}
  Domain.Inf.Contracts.Repositories.DomainRepository,
  Domain.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TDomainRepository = class(TRepository<TDomainEntity>, IDomainRepository)
  public
    function Find(const AId: TGuid): TDomainEntity; overload;
    function Find(const AName: string): TDomainEntity; overload;
    function FindAll: IList<TDomainEntity>;
  end;

implementation

{ TDomainRepository }

function TDomainRepository.Find(const AId: TGuid): TDomainEntity;
begin
  Result := inherited Find(AId);
end;

function TDomainRepository.Find(const AName: string): TDomainEntity;
begin
  Result := inherited Find(AName);
end;

function TDomainRepository.FindAll: IList<TDomainEntity>;
begin
  Result := Session.FindAll<TDomainEntity>;
end;

initialization
begin
  RegisterRepository(IDomainRepository, TDomainRepository);
end;

end.
