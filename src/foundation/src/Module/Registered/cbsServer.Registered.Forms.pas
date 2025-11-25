unit cbsServer.Registered.Forms;

interface

uses
{PROJECT}
  cbsServer.Contracts.Registered.Forms,
  cbsServer.Cybersoft.BaseForm;

type
  TcbsRegisteredForms = class(TInterfacedObject, IcbsRegisteredForms)
  strict private
    FFormClassList: IFormClassList;
  public
    constructor Create;
    destructor Destroy; override;
    function ToArray: TArray<TcbsFormClass>;
    procedure Add(const AFormClass: TcbsFormClass);
  end;

implementation

{ TcbsRegisteredForms }

constructor TcbsRegisteredForms.Create;
begin
  inherited Create;
  FFormClassList := CreateFormClassList;
end;

destructor TcbsRegisteredForms.Destroy;
begin
  FFormClassList.Clear;
  FFormClassList := nil;
  inherited;
end;

function TcbsRegisteredForms.ToArray: TArray<TcbsFormClass>;
begin
  Result := FFormClassList.ToArray;
end;

procedure TcbsRegisteredForms.Add(const AFormClass: TcbsFormClass);
begin
  if not FFormClassList.Contains(AFormClass) then
  begin
    FFormClassList.Add(AFormClass);
  end;
end;

end.
