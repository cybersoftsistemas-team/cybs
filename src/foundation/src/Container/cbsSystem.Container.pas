unit cbsSystem.Container;

interface

uses
{IDE}
  System.TypInfo,
  System.Rtti,
{PROJECT}
  cbsSystem.Contracts.Container;

type
  TContainer = class(TInterfacedObject, IContainer)
  private
    procedure Resolve(var AResult; AServiceType: PTypeInfo); overload;
    procedure Resolve(var AResult; AServiceType: PTypeInfo; const AParams: TParams); overload;
  public
    function MakeAll(const AServiceType: PTypeInfo): TArray<TValue>;
    procedure Make(var AResult; AServiceType: PTypeInfo); overload;
    procedure MakeWith(var AResult; AServiceType: PTypeInfo; const AParams: TParams);
    procedure Release(const AInstance: TObject); overload;
    procedure Release(const AInstance: IInterface); overload;
  end;

implementation

uses
{SPRING}
  Spring,
  Spring.Container;

{ TContainer }

function TContainer.MakeAll(const AServiceType: PTypeInfo): TArray<TValue>;
begin
  Result := GlobalContainer.ResolveAll(AServiceType);
end;

procedure TContainer.Make(var AResult; AServiceType: PTypeInfo);
begin
  Resolve(AResult, AServiceType);
end;

procedure TContainer.MakeWith(var AResult; AServiceType: PTypeInfo; const AParams: TParams);
begin
  Resolve(AResult, AServiceType, AParams);
end;

procedure TContainer.Release(const AInstance: IInterface);
begin
  GlobalContainer.Release(AInstance);
end;

procedure TContainer.Release(const AInstance: TObject);
begin
  GlobalContainer.Release(AInstance);
end;

procedure TContainer.Resolve(var AResult; AServiceType: PTypeInfo);
begin
  var LValue := GlobalContainer.Resolve(AServiceType, []);
  LValue.ExtractRawData(@AResult);
end;

procedure TContainer.Resolve(var AResult; AServiceType: PTypeInfo; const AParams: TParams);
begin
  var LValue := GlobalContainer.Resolve(AServiceType, AParams);
  LValue.AsTypeRelaxed(AServiceType, AResult);
end;

end.
