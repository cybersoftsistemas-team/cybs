unit cbsSystem.Support.Container.RegisterType;

interface

  procedure Bind(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean = False); overload;
  procedure Bind(AConcrete: TClass; const AShared: Boolean = False); overload;
  procedure BindIf(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean = False); overload;
  procedure BindIf(const AConcrete: TClass; const AShared: Boolean = False); overload;
  procedure Singleton(const abstract: TGuid; const AConcrete: TClass); overload;
  procedure Singleton(const AConcrete: TClass); overload;
  procedure SingletonIf(const abstract: TGuid; const AConcrete: TClass); overload;
  procedure SingletonIf(const AConcrete: TClass); overload;

implementation

uses
{PROJECT}
  cbsSystem.Support.RegisterContainer;

procedure Bind(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean);
begin
  Container.Bind(abstract, AConcrete, AShared);
end;

procedure Bind(AConcrete: TClass; const AShared: Boolean = False);
begin
  Container.Bind(AConcrete, AShared);
end;

procedure BindIf(const abstract: TGuid; const AConcrete: TClass; const AShared: Boolean);
begin
  Container.BindIf(abstract, AConcrete, AShared);
end;

procedure BindIf(const AConcrete: TClass; const AShared: Boolean = False);
begin
  Container.BindIf(AConcrete, AShared);
end;

procedure Singleton(const abstract: TGuid; const AConcrete: TClass);
begin
  Container.Singleton(abstract, AConcrete);
end;

procedure Singleton(const AConcrete: TClass);
begin
  Container.Singleton(AConcrete);
end;

procedure SingletonIf(const abstract: TGuid; const AConcrete: TClass);
begin
  Container.SingletonIf(abstract, AConcrete);
end;

procedure SingletonIf(const AConcrete: TClass);
begin
  Container.SingletonIf(AConcrete);
end;

end.
