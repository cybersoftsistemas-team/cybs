unit cbsSystem.Contracts.PathTree;

interface

uses
{IDE}
  System.Rtti,
{SPRING}
  Spring.Collections;

type
{$SCOPEDENUMS ON}
  TPathToken = (NewList, List, &End);
  TPathTokenOption = (Read, Write);
{$SCOPEDENUMS OFF}

  TPathList = TArray<string>;
  TPathTokenOptions = set of TPathTokenOption;

  IPathTree = interface(IUnknown)
    ['{7A5D9A91-3D6B-4E3B-9F2F-6C7D4E9A1111}']
    function Get(const APath: string; const ADefaultValue: TValue): TValue;
    procedure &Set(const APath: string; const AValue: TValue);
  end;

  IMemberList = IDictionary<string, TValue>;

  function CreateMemberList: IMemberList;

implementation

function CreateMemberList: IMemberList;
begin
  Result := TCollections.CreateDictionary<string, TValue>;
end;

end.
