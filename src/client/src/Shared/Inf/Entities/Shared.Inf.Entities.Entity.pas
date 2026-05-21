unit Shared.Inf.Entities.Entity;

interface

uses
{SPRING}
  Spring;

type
  TEntity = class
  private
    FCreatedAt: TDateTime;
    FUpdatedAt: Nullable<TDateTime>;
  protected
    property CreatedAt: TDateTime read FCreatedAt;
    property UpdatedAt: Nullable<TDateTime> read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.
