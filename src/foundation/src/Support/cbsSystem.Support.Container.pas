unit cbsSystem.Support.Container;

interface

uses
{PROJECT}
  cbsSystem.Contracts.Container;

type
  TParam = cbsSystem.Contracts.Container.TParam;

  App = record
  private
    class var FContainer: IContainer;
  public
    class function Make<T>: T; static;
    class function MakeWith<T>(const AParams: TParams): T; static;
    class procedure Release(const AInstance: TObject); overload; static;
    class procedure Release(const AInstance: IInterface); overload; static;
  end;

implementation

uses
{PROJECT}
  cbsSystem.Container;

{ App }

class function App.Make<T>: T;
begin
  FContainer.Make(Result, TypeInfo(T));
end;

class function App.MakeWith<T>(const AParams: TParams): T;
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

initialization
begin
  App.FContainer := TContainer.Create;
end;

finalization
begin
  App.FContainer := nil;
end;

end.
