unit Country.Inf.Seeders.damDbSeed;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
  Country.Inf.Contracts.Repositories.CountryCodeRepository,
  Country.Inf.Contracts.Repositories.CountryRepository,
  Country.Inf.Contracts.Repositories.NationalityRepository,
{SPRING}
  Spring.Container.Common,
{IDE}
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamCountryDbSeed = class(TDatabaseSeederModule)
  private
    [Inject] FCountryRepository: ICountryRepository;
    [Inject] FCountryCodeRepository: ICountryCodeRepository;
    [Inject] FNationalityRepository: INationalityRepository;
  protected
    procedure OnRunSeed; override;
    property CountryRepository: ICountryRepository read FCountryRepository;
    property CountryCodeRepository: ICountryCodeRepository read FCountryCodeRepository;
    property NationalityRepository: INationalityRepository read FNationalityRepository;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  Country.Dom.Common.SystemCountry,
  Country.Inf.Seeders.damDbSeed.Extensions;

{ TdamDbCountrySeed }

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
