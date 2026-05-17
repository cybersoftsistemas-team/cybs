unit cbsSystem.Support.Container;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Container,

  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TParam = cbsSystem.Contracts.Container.TParam;

  App = record
  private
    class var FContainer: IContainer;
  public
    class function Make(const AObjectType: TClass): TObject; overload; static;
    class function Make<T>: T; overload; static;
    class function MakeAll<T>: TArray<T>; static;
    class function MakeWith<T>(const AParams: cbsSystem.Contracts.Container.TParams): T; static;
    class procedure Release(const AInstance: TObject); overload; static;
    class procedure Release(const AInstance: IInterface); overload; static;
  end;

  TFDMemTableExtensions = class helper for TFDMemTable
  public
    procedure CreateAndCopyDataSet(
      const ASource: TDataSet;
      const AOptions: TFDCopyDataSetOptions = [coRestart, coAppend]
    );
  end;

implementation

uses
{IDE}
  System.Rtti,
{PROJECT}
  cbsSystem.Container,
{SPRING}
  Spring;

{ App }

class function App.Make(const AObjectType: TClass): TObject;
begin
  FContainer.Make(Result, AObjectType.ClassInfo);
end;

class function App.Make<T>: T;
begin
  FContainer.Make(Result, TypeInfo(T));
end;

class function App.MakeAll<T>: TArray<T>;
type
  TValueArray = array of TValue;
begin
  var LValues := FContainer.MakeAll(TypeInfo(T));
  SetLength(Result, Length(LValues));
  for var I := Low(LValues) to High(LValues) do
  begin
    TValueArray(LValues)[I].AsTypeRelaxed(TypeInfo(T), Result[I]);
  end;
end;

class function App.MakeWith<T>(const AParams: cbsSystem.Contracts.Container.TParams): T;
begin
  FContainer.MakeWith(Result, TypeInfo(T), AParams);
end;

class procedure App.Release(const AInstance: TObject);
begin
  FContainer.Release(AInstance);
end;

class procedure App.Release(const AInstance: IInterface);
begin
  FContainer.Release(AInstance);
end;

{ TFDMemTableExtensions }

procedure TFDMemTableExtensions.CreateAndCopyDataSet(
  const ASource: TDataSet;
  const AOptions: TFDCopyDataSetOptions
);
begin
  inherited CreateDataSet;
  CopyDataSet(ASource, AOptions);
end;

initialization
begin
  App.FContainer := cbsSystem.Container.TContainer.Create;
end;

finalization
begin
  App.FContainer := nil;
end;

end.
