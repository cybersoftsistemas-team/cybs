unit cbsSystem.Validation;

interface

uses
{PROJECT}
  cbsSystem.Contracts.MessageBag,
  cbsSystem.Contracts.Validation.Rule;

type
  TValidation = class(TInterfacedObject, IRule)
  private
    FMessageBag: IMessageBag;
  protected
    procedure Fail(const AKey, AMessage: string; const AParams: TParams = []);
    property Message: IMessageBag read FMessageBag;
  public
    constructor Create;
    destructor Destroy; override;
    function Messages: IMessageBag;
  end;

implementation

uses
{PROJECT}
  cbsSystem.MessageBag;

{ TValidation }

constructor TValidation.Create;
begin
  inherited Create;
  FMessageBag := TMessageBag.Create;
end;

destructor TValidation.Destroy;
begin
  FMessageBag := nil;
  inherited;
end;

procedure TValidation.Fail(const AKey, AMessage: string; const AParams: TParams);
begin
  FMessageBag.Add(AKey, AMessage, AParams);
end;

function TValidation.Messages: IMessageBag;
begin
  Result := FMessageBag;
end;

end.
