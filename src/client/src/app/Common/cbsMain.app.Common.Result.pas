unit cbsMain.app.Common.Result;

interface

type
  TResult<T, E> = record
  private
    FError: E;
    FIsSuccess: Boolean;
    FValue: T;
  public
    class function Fail(const AError: E): TResult<T, E>; overload; static;
    class function Fail(const AValue: T; const AError: E): TResult<T, E>; overload; static;
    class function Ok(const AValue: T): TResult<T, E>; static;
    property Error: E read FError;
    property IsSuccess: Boolean read FIsSuccess;
    property Value: T read FValue;
  end;

implementation

class function TResult<T, E>.Fail(const AError: E): TResult<T, E>;
begin
  Result := Fail(default(T), AError);
end;

class function TResult<T, E>.Fail(const AValue: T; const AError: E): TResult<T, E>;
begin
  Result.FIsSuccess := False;
  Result.FError := AError;
  Result.FValue := AValue;
end;

class function TResult<T, E>.Ok(const AValue: T): TResult<T, E>;
begin
  Result.FIsSuccess := True;
  Result.FValue := AValue;
end;

end.
