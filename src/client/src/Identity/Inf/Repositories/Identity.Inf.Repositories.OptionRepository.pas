unit Identity.Inf.Repositories.OptionRepository;

interface

uses
{PROJECT}
  Identity.Inf.Contracts.Repositories.OptionRepository,
  Identity.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TOptionRepository = class(TRepository<TOptionEntity>, IOptionRepository)
  public    
    function Find(const AId: TGuid): TOptionEntity;
  end;

implementation

{ TOptionRepository }

function TOptionRepository.Find(const AId: TGuid): TOptionEntity;
begin
  Result := inherited Find(AId);
end;

initialization
begin
  RegisterRepository(IOptionRepository, TOptionRepository);
end;

end.

