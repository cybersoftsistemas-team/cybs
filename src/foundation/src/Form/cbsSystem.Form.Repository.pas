unit cbsSystem.Form.Repository;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Form.Repository;

type
  TcbsFormTypeRepository = class(TInterfacedObject, IFormTypeRepository)
  private
    FFormTypeList: IFormTypeList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetFormTypes: IFormTypes;
    procedure Register(const AFormType: FormType);
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

procedure TcbsFormTypeRepository.Register(const AFormType: FormType);
begin
  if Assigned(AFormType) and
    not FFormTypeList.Contains(AFormType) then
  begin
    FFormTypeList.Add(AFormType);
  end;
end;

end.

