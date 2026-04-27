unit cbsUAuth.ui.Data.Modules.LoginDomainsModule;

interface

uses
{PROJECT}
  cbsSystem.Module.BaseModule,
{IDE}
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TdamLoginDomains = class(TdamBase)
    qryDOM: TFDQuery;
    qryDOMId: TGuidField;
    qryDOMName: TWideStringField;
    qryDOMParentId: TGuidField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function damLoginDomains: TdamLoginDomains;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
{PROJECT}
  cbsMain.ui.Data.Modules.MainModule,
  cbsSystem.Support.Module;

{$R *.dfm}

function damLoginDomains: TdamLoginDomains;
begin
  Result := TdamLoginDomains(damMain.GetModuleInstance(TdamLoginDomains));
end;

{ TdamLoginDomains }

procedure TdamLoginDomains.DataModuleCreate(Sender: TObject);
begin
  inherited;
  qryDOM.Close;
  qryDOM.Open;
end;

initialization
begin
  RegisterModuleType(TdamLoginDomains);
end;

end.
