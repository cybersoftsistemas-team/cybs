unit cbsUAuth.data.module.CustomerRegistrationModule;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
{IDE}
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.Client, System.Classes, Data.DB, FireDAC.Comp.DataSet;

type
  TdamCustomerRegistration = class(TdamBase)
    qryPLE: TFDQuery;
    qryPNA: TFDQuery;
    updPLE: TFDUpdateSQL;
    updPNA: TFDUpdateSQL;
    dsoPLE: TDataSource;
    dsoPNA: TDataSource;
  end;

  function damCustomerRegistration: TdamCustomerRegistration;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{PROJECT}
  cbsMain.data.module.MainModule;

function damCustomerRegistration: TdamCustomerRegistration;
begin
  Result := TdamCustomerRegistration(damMain.GetModuleInstance(TdamCustomerRegistration));
end;

end.
