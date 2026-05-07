unit cbsMain.dom.Contracts.Repository;

interface

uses
{PROJECT}
  cbsMain.inf.Entity;

type
  IRepository<TEntity: cbsMain.inf.Entity.TEntity, constructor> = interface(IUnknown)
    ['{FA1535BE-2D6D-430F-A416-D39220A28506}']
    procedure Save(const AEntity: TEntity);
  end;

implementation

end.
