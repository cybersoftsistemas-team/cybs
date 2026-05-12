unit Address.Inf.Repositories.StreetTypeRepository;

interface

uses
{PROJECT}
  Address.Inf.Contracts.Repositories.StreetTypeRepository,
  Address.Inf.Entities,
  Shared.Inf.Repositories.Repository;

type
  TStreetTypeRepository = class(TRepository<TStreetTypeEntity>, IStreetTypeRepository)
  public
    function Find(const AId: TGuid): TStreetTypeEntity; overload;
    function Find(const AName: string): TStreetTypeEntity; overload;
  end;

implementation

{ TStreetTypeRepository }

function TStreetTypeRepository.Find(const AId: TGuid): TStreetTypeEntity;
begin
  Result := inherited Find(AId);
end;

function TStreetTypeRepository.Find(const AName: string): TStreetTypeEntity;
begin
  Result := inherited Find(AName);
end;

initialization
begin
  RegisterRepository(IStreetTypeRepository, TStreetTypeRepository);
end;

end.



