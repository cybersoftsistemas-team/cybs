unit cbsSystem.Translation.ForReplacement;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsSystem.Support.Types;

type
  TForReplacement = record
  private
    class function MatchCaseAdvanced(const ASource, AValue: string): string; static;
  public
    class function Resolve(const AText: string; const AReplacements: TForReplacements): string; static;
  end;

implementation

uses
{IDE}
  System.Character,
  System.RegularExpressions,
{SPRING}
  Spring.Collections;

type
  TParamState = record
    Values: TArray<string>;
    Index: Integer;
  end;

  IMapList = IDictionary<string, TParamState>;

function CreateMapList: IMapList;
begin
  Result := TCollections.CreateDictionary<string, TParamState>;
end;

{ TForReplacement }

class function TForReplacement.MatchCaseAdvanced(const ASource, AValue: string): string;
begin
  if ASource.IsEmpty or AValue.IsEmpty then
    Exit(AValue);
  var LenSource := ASource.Length;
  var LenValue  := AValue.Length;
  SetLength(Result, LenValue);
  var LastIsUpper := ASource[LenSource].IsUpper;
  for var I := 1 to LenValue do
  begin
    var LChar := AValue[I];
    if I <= LenSource then
      LastIsUpper := ASource[I].IsUpper;
    if LastIsUpper then
      Result[I] := LChar.ToUpper
    else
      Result[I] := LChar.ToLower;
  end;
end;

class function TForReplacement.Resolve(const AText: string; const AReplacements: TForReplacements): string;
begin
  if AText.IsEmpty or (Length(AReplacements) = 0) then
    Exit(AText);
  var LRegex := TRegEx.Create(':(\w+)', [roIgnoreCase]);
  var LMatches := LRegex.Matches(AText);
  if LMatches.Count = 0 then
    Exit(AText);
  var LMap := CreateMapList;
  try
    for var LItem in AReplacements do
    begin
      if Length(LItem) < 2 then
        Continue;
      var LKey := LItem[0].ToLower;
      var LValue := LItem[1];
      var LState: TParamState;
      if not LMap.TryGetValue(LKey, LState) then
      begin
        LState.Values := [];
        LState.Index := 0;
      end;
      var Len := Length(LState.Values);
      SetLength(LState.Values, Len + 1);
      LState.Values[Len] := LValue;
      LMap[LKey] := LState;
    end;
    var LBuilder := TStringBuilder.Create;
    try
      var LastIndex := 1;
      for var LMatch in LMatches do
      begin
        var LStart := LMatch.Index;
        LBuilder.Append(AText.Substring(LastIndex - 1, LStart - LastIndex));
        var LKeyOriginal := LMatch.Groups[1].Value;
        var LKey := LKeyOriginal.ToLower;
        var LState: TParamState;
        if LMap.TryGetValue(LKey, LState) then
        begin
          var LValue: string;
          if LState.Index < Length(LState.Values) then
          begin
            LValue := LState.Values[LState.Index];
            Inc(LState.Index);
            LMap[LKey] := LState;
          end
          else
          begin
            LValue := LState.Values[High(LState.Values)];
          end;
          LBuilder.Append(MatchCaseAdvanced(LKeyOriginal, LValue));
        end
        else
        begin
          LBuilder.Append(LMatch.Value);
        end;
        LastIndex := LStart + LMatch.Length;
      end;
      LBuilder.Append(AText.Substring(LastIndex - 1));
      Result := LBuilder.ToString;
    finally
      LBuilder.Free;
    end;
  finally
    LMap := nil;
  end;
end;

end.





