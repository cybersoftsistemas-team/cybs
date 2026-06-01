unit General.Inf.Seeders.damDbSeed;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
  General.Inf.Contracts.Repositories.CategoryRepository,
{SPRING}
  Spring.Container.Common,
{IDE}
  System.SysUtils, System.Classes, FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamGeneralDbSeed = class(TDatabaseSeederModule)
  private
    [Inject] FCategoryRepository: ICategoryRepository;
  protected
    procedure OnRunSeed; override;
    property CategoryRepository: ICategoryRepository read FCategoryRepository;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  General.Dom.Common.SystemAddress,
  General.Dom.Common.SystemBusinessTypes,
  General.Dom.Common.SystemCatalog,
  General.Dom.Common.SystemEmails,
  General.Dom.Common.SystemGender,
  General.Dom.Common.SystemIReferenceTypes,
  General.Dom.Common.SystemIReservationStatus,
  General.Dom.Common.SystemITransactionTypes,
  General.Dom.Common.SystemMeasureTypes,
  General.Dom.Common.SystemPersonTypes,
  General.Dom.Common.SystemPGCDataTypes,
  General.Dom.Common.SystemPhones,
  General.Inf.Seeders.damDbSeed.Extensions;

{ TdamGeneralDbSeed }

procedure TdamGeneralDbSeed.OnRunSeed;
begin
  // =============================================================================================================
  // Categories
  // =============================================================================================================

  // Emails
  CreateCategory(TSystemEmails.EmailsId              , 'Emails'           , TGuid.Empty                         );
  CreateCategory(TSystemEmails.EmailId               , 'Email'            , TSystemEmails.EmailsId              );
  CreateCategory(TSystemEmails.Email2Id              , 'Email 2'          , TSystemEmails.EmailsId              );
  CreateCategory(TSystemEmails.OtherId               , 'Outro'            , TSystemEmails.EmailsId              );
  // Endereço
  CreateCategory(TSystemAddress.AddressId            , 'Endereço'         , TGuid.Empty                         );
  CreateCategory(TSystemAddress.BusinessId           , 'Comercial'        , TSystemAddress.AddressId            );
  CreateCategory(TSystemAddress.ResidentialId        , 'Residencial'      , TSystemAddress.AddressId            );
  CreateCategory(TSystemAddress.OtherId              , 'Outro'            , TSystemAddress.AddressId            );
  // Telefones
  CreateCategory(TSystemPhones.PhonesId              , 'Telefones'        , TGuid.Empty                         );
  CreateCategory(TSystemPhones.AssistantId           , 'Assistente'       , TSystemPhones.PhonesId              );
  CreateCategory(TSystemPhones.MobileId              , 'Celular'          , TSystemPhones.PhonesId              );
  CreateCategory(TSystemPhones.Mobile2Id             , 'Celular 2'        , TSystemPhones.PhonesId              );
  CreateCategory(TSystemPhones.BusinessId            , 'Comercial'        , TSystemPhones.PhonesId              );
  // Tipos de Empresa
  CreateCategory(TSystemBusinessTypes.BusinessTypeId , 'Tipos de Empresa' , TGuid.Empty                         );
  CreateCategory(TSystemBusinessTypes.PublicId       , 'Pública'          , TSystemBusinessTypes.BusinessTypeId );
  CreateCategory(TSystemBusinessTypes.PrivateId      , 'Privada'          , TSystemBusinessTypes.BusinessTypeId );
  // Gêneros
  CreateCategory(TSystemGender.GenderId              , 'Sexo'             , TGuid.Empty                         );
  CreateCategory(TSystemGender.FemaleId              , 'Feminino'         , TSystemGender.GenderId              );
  CreateCategory(TSystemGender.MaleId                , 'Masculino'        , TSystemGender.GenderId              );
  // Tipos de Pessoa
  CreateCategory(TSystemPersonTypes.PersonTypeId     , 'Tipos de Pessoa'  , TGuid.Empty                         );
  CreateCategory(TSystemPersonTypes.NaturalId        , 'Física'           , TSystemPersonTypes.PersonTypeId     );
  CreateCategory(TSystemPersonTypes.LegalId          , 'Jurídica'         , TSystemPersonTypes.PersonTypeId     );
  // Catálogo
  CreateCategory(TSystemCatalog.CatalogTypeId        , 'Catálogo'         , TGuid.Empty                         );
  CreateCategory(TSystemCatalog.ProductTypeId        , 'Produto'          , TSystemCatalog.CatalogTypeId        );
  CreateCategory(TSystemCatalog.ServiceTypeId        , 'Serviço'          , TSystemCatalog.CatalogTypeId        );
  // Tipos de medidas
  CreateCategory(TSystemMeasureTypes.MeasureTypeId   , 'Tipos de medidas' , TGuid.Empty                         );
  CreateCategory(TSystemMeasureTypes.WeightId        , 'Peso'             , TSystemMeasureTypes.MeasureTypeId   );
  CreateCategory(TSystemMeasureTypes.LengthId        , 'Comprimento'      , TSystemMeasureTypes.MeasureTypeId   );
  CreateCategory(TSystemMeasureTypes.VolumeId        , 'Volume'           , TSystemMeasureTypes.MeasureTypeId   );
  CreateCategory(TSystemMeasureTypes.AreaId          , 'Área'             , TSystemMeasureTypes.MeasureTypeId   );
  CreateCategory(TSystemMeasureTypes.CountId         , 'Contagem'         , TSystemMeasureTypes.MeasureTypeId   );
  CreateCategory(TSystemMeasureTypes.TimeId          , 'Tempo'            , TSystemMeasureTypes.MeasureTypeId   );
  // Tipos de dados de coluna de grade de produto
  CreateCategory(TSystemPGCDataTypes.DataTypesId     , 'Tipos de dados de coluna de grade de produto'
                                                                          , TGuid.Empty                         );
  CreateCategory(TSystemPGCDataTypes.BooleanTypeId   , 'Boolean'          , TSystemPGCDataTypes.DataTypesId     );
  CreateCategory(TSystemPGCDataTypes.DateTimeTypeId  , 'DateTime'         , TSystemPGCDataTypes.DataTypesId     );
  CreateCategory(TSystemPGCDataTypes.DateTypeId      , 'Date'             , TSystemPGCDataTypes.DataTypesId     );
  CreateCategory(TSystemPGCDataTypes.DecimalTypeId   , 'Decimal'          , TSystemPGCDataTypes.DataTypesId     );
  CreateCategory(TSystemPGCDataTypes.IntegerTypeId   , 'Integer'          , TSystemPGCDataTypes.DataTypesId     );
  CreateCategory(TSystemPGCDataTypes.TextTypeId      , 'Text'             , TSystemPGCDataTypes.DataTypesId     );
  CreateCategory(TSystemPGCDataTypes.TimeTypeId      , 'Time'             , TSystemPGCDataTypes.DataTypesId     );
  // Tipos de transações de estoque
  CreateCategory(TSystemITransTypes.ITransTypesId       , 'Tipos de transações de estoque'
                                                                                , TGuid.Empty                      );
  CreateCategory(TSystemITransTypes.AdjustmentTypeId    , 'Ajuste'              , TSystemITransTypes.ITransTypesId );
  CreateCategory(TSystemITransTypes.PurchaseTypeId      , 'Compra'              , TSystemITransTypes.ITransTypesId );
  CreateCategory(TSystemITransTypes.TransferInTypeId    , 'Entrada'             , TSystemITransTypes.ITransTypesId );
  CreateCategory(TSystemITransTypes.ProductionInTypeId  , 'Entrada de Produção' , TSystemITransTypes.ITransTypesId );
  CreateCategory(TSystemITransTypes.InventoryTypeId     , 'Estoque'             , TSystemITransTypes.ITransTypesId );
  CreateCategory(TSystemITransTypes.TransferOutTypeId   , 'Saída'               , TSystemITransTypes.ITransTypesId );
  CreateCategory(TSystemITransTypes.ProductionOutTypeId , 'Saída de Produção'   , TSystemITransTypes.ITransTypesId );
  CreateCategory(TSystemITransTypes.SaleTypeId          , 'Venda'               , TSystemITransTypes.ITransTypesId );
  // Tipos de referências de estoque
  CreateCategory(TSystemIReferenceTypes.IReferenceTypesId     , 'Tipos de referências de estoque'
                                                                                         , TGuid.Empty                              );
  CreateCategory(TSystemIReferenceTypes.IAdjustmentTypeId     , 'Ajuste de Estoque'      , TSystemIReferenceTypes.IReferenceTypesId );
  CreateCategory(TSystemIReferenceTypes.ProductionOrderTypeId , 'Ordem de Produção'      , TSystemIReferenceTypes.IReferenceTypesId );
  CreateCategory(TSystemIReferenceTypes.TransferOrderTypeId   , 'Ordem de Transferência' , TSystemIReferenceTypes.IReferenceTypesId );
  CreateCategory(TSystemIReferenceTypes.PurchaseOrderTypeId   , 'Pedido de Compra'       , TSystemIReferenceTypes.IReferenceTypesId );
  CreateCategory(TSystemIReferenceTypes.SalesOrderTypeId      , 'Pedido de Venda'        , TSystemIReferenceTypes.IReferenceTypesId );
  //
  CreateCategory(TSystemIReservationStatus.IReservationStatusTypeId , 'Status da reserva de estoque'
                                                                                                , TGuid.Empty                                        );
  CreateCategory(TSystemIReservationStatus.ActiveTypeId             , 'Ativo'                   , TSystemIReservationStatus.IReservationStatusTypeId );
  CreateCategory(TSystemIReservationStatus.CancelledTypeId          , 'Cancelado'               , TSystemIReservationStatus.IReservationStatusTypeId );
  CreateCategory(TSystemIReservationStatus.ConsumedTypeId           , 'Consumido'               , TSystemIReservationStatus.IReservationStatusTypeId );
  CreateCategory(TSystemIReservationStatus.ExpiredTypeId            , 'Expirado'                , TSystemIReservationStatus.IReservationStatusTypeId );
  inherited;
end;

end.
