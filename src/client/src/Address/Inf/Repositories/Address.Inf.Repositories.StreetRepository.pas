unit Address.Inf.Repositories.StreetRepository;

interface

uses
{PROJECT}
  Address.Inf.Contracts.Repositories.StreetRepository,
  Address.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TStreetRepository = class(TRepository<TStreetEntity>, IStreetRepository)
  public
    function Find(const AId: TGuid): TStreetEntity; overload;
    function Find(const AName: string): TStreetEntity; overload;
  end;

implementation

{ TStreetRepository }

function TStreetRepository.Find(const AId: TGuid): TStreetEntity;
begin
  Result := inherited Find(AId);
end;

function TStreetRepository.Find(const AName: string): TStreetEntity;
begin
  Result := inherited Find(AName);
end;

initialization
begin
  RegisterRepository(IStreetRepository, TStreetRepository);
end;

end.



