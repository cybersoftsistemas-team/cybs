unit cbsServer.Form.Registered;

interface

uses
{PROJECT}
  cbsServer.Contracts.Form.Registered,
  cbsServer.Form.BaseForm;

type
  TcbsFormRegistered = class(TInterfacedObject, IcbsFormRegistered)
  strict private
    FFormClassList: IFormClassList;
  public
    constructor Create;
    destructor Destroy; override;
    function ToArray: TArray<TcbsFormClass>;
    procedure Add(const AFormClass: TcbsFormClass);
  end;

implementation

{ TcbsFormRegistered }

constructor TcbsFormRegistered.Create;
begin
  inherited Create;
  FFormClassList := CreateFormClassList;
end;

destructor TcbsFormRegistered.Destroy;
begin
  FFormClassList.Clear;
  FFormClassList := nil;
  inherited;
end;

function TcbsFormRegistered.ToArray: TArray<TcbsFormClass>;
begin
  Result := FFormClassList.ToArray;
end;

procedure TcbsFormRegistered.Add(const AFormClass: TcbsFormClass);
begin
  if not FFormClassList.Contains(AFormClass) then
  begin
    FFormClassList.Add(AFormClass);
  end;
end;

end.
