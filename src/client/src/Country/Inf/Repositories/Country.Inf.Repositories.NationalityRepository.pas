unit Country.Inf.Repositories.NationalityRepository;

interface

uses
{PROJECT}
  Country.Inf.Contracts.Repositories.NationalityRepository,
  Country.Inf.Entities,
  Shared.Inf.Repositories.Repository,
{SPRING}
  Spring.Collections;

type
  TNationalityRepository = class(TRepository<TNationalityEntity>, INationalityRepository)
  public
    function Find(const AId: TGuid): TNationalityEntity; overload;
    function Find(const AName: string): TNationalityEntity; overload;
  end;

implementation

{ TNationalityRepository }

function TNationalityRepository.Find(const AId: TGuid): TNationalityEntity;
begin
  Result := inherited Find(AId);
end;

function TNationalityRepository.Find(const AName: string): TNationalityEntity;
begin
  Result := inherited Find(AName);
end;

initialization
begin
  RegisterRepository(INationalityRepository, TNationalityRepository);
end;

end.
