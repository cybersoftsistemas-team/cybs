unit General.Inf.Seeders.damDbSeed.Extensions;

interface

uses
{PROJECT}
  General.Inf.Seeders.damDbSeed;

type
  TdamGeneralDbSeedExtensions = class helper for TdamGeneralDbSeed
  public
    procedure CreateCategory(const AId: TGuid; const AName: string; const AParentId: TGuid);
  end;

implementation

uses
{PROJECT}
  General.Inf.Entities;

{ TdamGeneralDbSeedExtensions }

procedure TdamGeneralDbSeedExtensions.CreateCategory(const AId: TGuid; const AName: string; const AParentId: TGuid);
begin
  var LEntity := CategoryRepository.Find(AId);
  if not Assigned(LEntity) then
    LEntity := TCategoryEntity.Create;
  LEntity.Id := AId;
  LEntity.Name := AName;
  LEntity.Reserved := True;
  if not AParentId.IsEmpty then
    LEntity.ParentId := AParentId;
  CategoryRepository.Save(LEntity);
end;

end.
