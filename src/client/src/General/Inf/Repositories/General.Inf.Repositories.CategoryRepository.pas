unit General.Inf.Repositories.CategoryRepository;

interface

uses
{PROJECT}
  General.Inf.Contracts.Repositories.CategoryRepository,
  General.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TCategoryRepository = class(TRepository<TCategoryEntity>, ICategoryRepository)
  public
    function Find(const AId: TGuid): TCategoryEntity;
  end;

implementation

{ TCategoryRepository }

function TCategoryRepository.Find(const AId: TGuid): TCategoryEntity;
begin
  Result := inherited Find(AId);
end;

initialization
begin
  RegisterRepository(ICategoryRepository, TCategoryRepository);
end;

end.
