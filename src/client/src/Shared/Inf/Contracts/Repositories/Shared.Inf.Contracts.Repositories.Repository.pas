unit Shared.Inf.Contracts.Repositories.Repository;

interface

uses
{PROJECT}
  Shared.Inf.Entities.Entity;

type
  IRepository<TEntity: Shared.Inf.Entities.Entity.TEntity, constructor> = interface(IUnknown)
    ['{FA1535BE-2D6D-430F-A416-D39220A28506}']
    procedure Insert(const AEntity: TEntity);
    procedure Save(const AEntity: TEntity);
    procedure Update(const AEntity: TEntity);
  end;

implementation

end.
