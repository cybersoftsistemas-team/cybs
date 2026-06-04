unit Catalog.Inf.Seeders.damDbSeed.Extensions;

interface

uses
{PROJECT}
  Catalog.Inf.Seeders.damDbSeed;

type
  TdamCatalogDbSeedExtensions = class helper for TdamCatalogDbSeed
  public
    procedure CreateConfig;
  end;

implementation

uses
{PROJECT}
  Catalog.Inf.Entities;

{ TdamCatalogDbSeedExtensions }

procedure TdamCatalogDbSeedExtensions.CreateConfig;
begin
  ConfigRepository.GetConfig.Free;
end;

end.
