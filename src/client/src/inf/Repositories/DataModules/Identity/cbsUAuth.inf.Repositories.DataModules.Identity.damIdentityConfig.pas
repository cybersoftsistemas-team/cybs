unit cbsUAuth.inf.Repositories.DataModules.Identity.damIdentityConfig;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
  cbsUAuth.dom.Contracts.Entities.Identity.Config,
{IDE}
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdamIdentityConfig = class(TdamBase)
    qryCON: TFDQuery;
  private
    function GetMappedConfig(const ADataSet: TDataSet): IIdentityConfig;
  public
    function GetConfig: IIdentityConfig;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
{PROJECT}
  cbsMain.inf.DbModule,
  cbsSystem.Support.Container;

function TdamIdentityConfig.GetConfig: IIdentityConfig;
begin
  qryCON.Close;
  qryCON.Open;
  Result := GetMappedConfig(qryCON);
end;

function TdamIdentityConfig.GetMappedConfig(const ADataSet: TDataSet): IIdentityConfig;
begin
   Result := App.Make<IIdentityConfig>;
   if not ADataSet.IsEmpty then
  begin
    Result.LockoutMinutes := ADataSet.FieldByName('LockoutMinutes').AsInteger;
    Result.MaxAttempts := ADataSet.FieldByName('MaxAttempts').AsInteger;
    Result.PasswordIterations := ADataSet.FieldByName('PasswordIterations').AsInteger;
  end;
end;

end.
