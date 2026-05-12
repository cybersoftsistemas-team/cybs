unit Country.Inf.Seeders.damDbSeed;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
  Country.Inf.Contracts.Repositories.CountryCodeRepository,
  Country.Inf.Contracts.Repositories.CountryRepository,
  Country.Inf.Contracts.Repositories.NationalityRepository,
{IDE}
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamCountryDbSeed = class(TDatabaseSeederModule)
  private
    FCountryRepository: ICountryRepository;
    FCountryCodeRepository: ICountryCodeRepository;
    FNationalityRepository: INationalityRepository;

    procedure CreateCountry(
      const AId: TGuid;
      const AName: string;
      const ADialCode: string
    );

    procedure CreateCountryCode(
      const ACodeType: string;
      const ACode: string;
      const ACountryId: TGuid
    );

    procedure CreateNationality(
      const AName: string;
      const ACountryId: TGuid
    );

  protected
    procedure OnRunSeed; override;
  public

    constructor Create(
      const ACountryRepository: ICountryRepository;
      const ACountryCodeRepository: ICountryCodeRepository;
      const ANationalityRepository: INationalityRepository
    ); reintroduce;

  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  cbsSystem.Support.Container,
  Country.Dom.Common.SystemCountry,
  Country.Inf.Entities;

{ TdamDbCountrySeed }

constructor TdamCountryDbSeed.Create(
  const ACountryRepository: ICountryRepository;
  const ACountryCodeRepository: ICountryCodeRepository;
  const ANationalityRepository: INationalityRepository
);
begin
  inherited Create(nil);
  FCountryRepository := ACountryRepository;
  FCountryCodeRepository := ACountryCodeRepository;
  FNationalityRepository := ANationalityRepository;
end;

procedure TdamCountryDbSeed.CreateCountry(
  const AId: TGuid;
  const AName, ADialCode: string
);
begin
  var LEntity := FCountryRepository.Find(AName);
  if not Assigned(LEntity) then
    LEntity := TCountryEntity.Create;
  LEntity.Id := AId;
  LEntity.Name := AName;
  LEntity.DialCode := ADialCode;
  FCountryRepository.Save(LEntity);
end;

procedure TdamCountryDbSeed.CreateCountryCode(
  const ACodeType, ACode: string;
  const ACountryId: TGuid
);
begin
  var LEntity := FCountryCodeRepository.Find(ACodeType, ACode);
  if not Assigned(LEntity) then
  begin
    LEntity := TCountryCodeEntity.Create;
    LEntity.CodeType := ACodeType;
    LEntity.Code := ACode;
    LEntity.CountryId := ACountryId;
    FCountryCodeRepository.Insert(LEntity);
  end;
end;

procedure TdamCountryDbSeed.CreateNationality(
  const AName: string;
  const ACountryId: TGuid
);
begin
  var LEntity := FNationalityRepository.Find(ACountryId);
  if not Assigned(LEntity) then
    LEntity := TNationalityEntity.Create;
  LEntity.Id := ACountryId;
  LEntity.Name := AName;
  FNationalityRepository.Save(LEntity);
end;

procedure TdamCountryDbSeed.OnRunSeed;
begin
  // ============================================================
  // Countries
  // ============================================================

  CreateCountry(TSystemCountry.BrazilId, 'Brasil', '+55' );

  // ============================================================
  // Country codes
  // ============================================================

  CreateCountryCode('ISO2'   , 'BR'  , TSystemCountry.BrazilId );
  CreateCountryCode('ISO3'   , 'BRA' , TSystemCountry.BrazilId );
  CreateCountryCode('NUMERIC', '076' , TSystemCountry.BrazilId );
  CreateCountryCode('IBGE'   , '1058', TSystemCountry.BrazilId );
  CreateCountryCode('BACEN'  , '076' , TSystemCountry.BrazilId );

  // ============================================================
  // Nationalities
  // ============================================================

  CreateNationality('Brasileiro', TSystemCountry.BrazilId );
  inherited;
end;

end.
