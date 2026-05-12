unit General.Inf.Seeders.damDbSeed;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
  General.Inf.Contracts.Repositories.CategoryRepository,
{IDE}
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamGeneralDbSeed = class(TDatabaseSeederModule)
  private
    FCategoryRepository: ICategoryRepository;
  protected
    procedure OnRunSeed; override;
    property CategoryRepository: ICategoryRepository read FCategoryRepository;
  public
    constructor Create(
      const ACategoryRepository: ICategoryRepository
    ); reintroduce;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  General.Dom.Common.SystemAddress,
  General.Dom.Common.SystemBusinessTypes,
  General.Dom.Common.SystemEmails,
  General.Dom.Common.SystemGender,
  General.Dom.Common.SystemPersonTypes,
  General.Dom.Common.SystemPhones,
  General.Inf.Seeders.damDbSeed.Extensions;

{ TdamGeneralDbSeed }

constructor TdamGeneralDbSeed.Create(
  const ACategoryRepository: ICategoryRepository
);
begin
  inherited Create(nil);
  FCategoryRepository := ACategoryRepository;
end;

procedure TdamGeneralDbSeed.OnRunSeed;
begin
  // ============================================================================================================
  // Categories
  // ============================================================================================================

  // Emails
  CreateCategory(TSystemEmails.EmailsId              , 'Emails'          , TGuid.Empty                         );
  CreateCategory(TSystemEmails.EmailId               , 'Email'           , TSystemEmails.EmailsId              );
  CreateCategory(TSystemEmails.Email2Id              , 'Email 2'         , TSystemEmails.EmailsId              );
  CreateCategory(TSystemEmails.OtherId               , 'Outro'           , TSystemEmails.EmailsId              );
  // Endereço
  CreateCategory(TSystemAddress.AddressId            , 'Endereço'        , TGuid.Empty                         );
  CreateCategory(TSystemAddress.BusinessId           , 'Comercial'       , TSystemAddress.AddressId            );
  CreateCategory(TSystemAddress.ResidentialId        , 'Residencial'     , TSystemAddress.AddressId            );
  CreateCategory(TSystemAddress.OtherId              , 'Outro'           , TSystemAddress.AddressId            );
  // Telefones
  CreateCategory(TSystemPhones.PhonesId              , 'Telefones'       , TGuid.Empty                         );
  CreateCategory(TSystemPhones.AssistantId           , 'Assistente'      , TSystemPhones.PhonesId              );
  CreateCategory(TSystemPhones.MobileId              , 'Celular'         , TSystemPhones.PhonesId              );
  CreateCategory(TSystemPhones.Mobile2Id             , 'Celular 2'       , TSystemPhones.PhonesId              );
  CreateCategory(TSystemPhones.BusinessId            , 'Comercial'       , TSystemPhones.PhonesId              );
  // Tipos de Empresa
  CreateCategory(TSystemBusinessTypes.BusinessTypeId , 'Tipos de Empresa', TGuid.Empty                         );
  CreateCategory(TSystemBusinessTypes.PublicId       , 'Pública'         , TSystemBusinessTypes.BusinessTypeId );
  CreateCategory(TSystemBusinessTypes.PrivateId      , 'Privada'         , TSystemBusinessTypes.BusinessTypeId );
  // Gêneros
  CreateCategory(TSystemGender.GenderId              , 'Sexo'            , TGuid.Empty                         );
  CreateCategory(TSystemGender.FemaleId              , 'Feminino'        , TSystemGender.GenderId              );
  CreateCategory(TSystemGender.MaleId                , 'Masculino'       , TSystemGender.GenderId              );
  // Tipos de Pessoa
  CreateCategory(TSystemPersonTypes.PersonTypeId     , 'Tipos de Pessoa' , TGuid.Empty                         );
  CreateCategory(TSystemPersonTypes.NaturalId        , 'Física'          , TSystemPersonTypes.PersonTypeId     );
  CreateCategory(TSystemPersonTypes.LegalId          , 'Jurídica'        , TSystemPersonTypes.PersonTypeId     );
  inherited;
end;

end.
