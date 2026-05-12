unit Shared.Core.Common.ActionResult;

interface

type
  TActionResult<T> = record
  private
    FIsSuccess: Boolean;
    FValue: T;
  public
    class function Fail(const AError: T): TActionResult<T>; static;
    class function Ok(const AValue: T): TActionResult<T>; static;
    property IsSuccess: Boolean read FIsSuccess;
    property Value: T read FValue;
  end;

implementation

{ TActionResult<T> }

class function TActionResult<T>.Fail(const AError: T): TActionResult<T>;
begin
  Result.FIsSuccess := False;
  Result.FValue := AError;
end;

class function TActionResult<T>.Ok(const AValue: T): TActionResult<T>;
begin
  Result.FIsSuccess := True;
  Result.FValue := AValue;
end;

end.
