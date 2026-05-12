unit Address.Inf.Contracts.Repositories.StateCodeRepository;

interface

uses
{PROJECT}
  Address.Inf.Entities,
  Shared.Inf.Contracts.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  IStateCodeRepository = interface(IRepository<TStateCodeEntity>)
    ['{6E517E09-BC5B-444F-AC4F-F71BFE4CC505}']
    function Find(const ACodeType: string; const ACode: string): TStateCodeEntity; overload;
    function Find(const ACodeType: string; const AStateId: TGuid): TStateCodeEntity; overload;
    function FindByStateId(const AStateId: TGuid): IList<TStateCodeEntity>;
  end;

implementation

end.


