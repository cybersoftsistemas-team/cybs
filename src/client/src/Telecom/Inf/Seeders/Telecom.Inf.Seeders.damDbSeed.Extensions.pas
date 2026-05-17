unit Telecom.Inf.Seeders.damDbSeed.Extensions;

interface

uses
{PROJECT}
  Telecom.Inf.Seeders.damDbSeed;

type
  TdamTelecomDbSeedExtensions = class helper for TdamTelecomDbSeed
  public
    procedure CreateAreaCode(const AAreaCode: string; const AStateId: TGuid);
  end;

implementation

uses
{PROJECT}
  Telecom.Inf.Entities;

{ TdamTelecomDbSeedExtensions }

procedure TdamTelecomDbSeedExtensions.CreateAreaCode(const AAreaCode: string; const AStateId: TGuid);
begin
  var LEntity := AreaCodeRepository.Find(AAreaCode, AStateId);
  try
    if not Assigned(LEntity) then
    begin
      LEntity := TAreaCodeEntity.Create;
      LEntity.AreaCode := AAreaCode;
      LEntity.StateId := AStateId;
      AreaCodeRepository.Insert(LEntity);
    end;
  finally
    LEntity.Free;
  end;
end;

end.
