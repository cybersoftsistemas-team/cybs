unit General.Inf.Contracts.Repositories.CategoryRepository;

interface

uses
{PROJECT}
  General.Inf.Entities,
  Shared.inf.Contracts.Repositories.Repository;

type
  ICategoryRepository = interface(IRepository<TCategoryEntity>)
    ['{402ABCA2-7D24-4832-88AA-795ED012C40E}']
    function Find(const AId: TGuid): TCategoryEntity;
  end;

implementation

end.
