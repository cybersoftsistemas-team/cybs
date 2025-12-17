unit cbsSystem.Form.Repository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.Repository;

type
  TcbsFormTypeRepository = class(TInterfacedObject, IFormTypeRepository)
  private
    FFormTypeList: IFormTypeList;
    FMainFormType: FormType;
  public
    constructor Create;
    destructor Destroy; override;
    function GetFormTypes: IFormTypes;
    function GetMainFormType: FormType;
    procedure Register(const AFormType: FormType);
    procedure RegisterMain(const AFormType: FormType);
  end;

implementation

{ TcbsFormTypeRepository }

constructor TcbsFormTypeRepository.Create;
begin
  inherited Create;
  FFormTypeList := CreateFormTypeList;
end;

destructor TcbsFormTypeRepository.Destroy;
begin
  FFormTypeList := nil;
  inherited;
end;

function TcbsFormTypeRepository.GetFormTypes: IFormTypes;
begin
  Result := FFormTypeList;
end;

function TcbsFormTypeRepository.GetMainFormType: FormType;
begin
  Result := FMainFormType;
end;

procedure TcbsFormTypeRepository.Register(const AFormType: FormType);
begin
  if Assigned(AFormType) and
    not FFormTypeList.Contains(AFormType) then
  begin
    FFormTypeList.Add(AFormType);
  end;
end;

procedure TcbsFormTypeRepository.RegisterMain(const AFormType: FormType);
begin
  FMainFormType := AFormType;
end;

end.

