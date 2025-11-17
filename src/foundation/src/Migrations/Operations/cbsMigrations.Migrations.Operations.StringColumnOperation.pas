unit cbsMigrations.Migrations.Operations.StringColumnOperation;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.Operations.StringColumnOperation,
  cbsMigrations.Migrations.Operations.LengthColumnOperation;

type
  TStringColumnOperation = class(TLengthColumnOperation, IStringColumnOperation)
  private
    FCollation: string;
    FFixedLength: Boolean;
    FMaxLength: Boolean;
    FUnicode: Boolean;
    function GetCollation: string;
    function GetFixedLength: Boolean;
    function GetMaxLength: Boolean;
    function GetUnicode: Boolean;
  public
    constructor Create(const AName: string);
    function HasCollation(const ACollation: string): IStringColumnOperation;
    function HasColumnType(const AColumnType: string): IStringColumnOperation;
    function HasDefaultValueSql(const ADefaultValueSql: string): IStringColumnOperation;
    function HasMaxLength(const ALength: Integer): IStringColumnOperation;
    function HasSchema(const ASchema: string): IStringColumnOperation;
    function HasTable(const ATable: string): IStringColumnOperation;
    function HasUnicode(const AUnicode: Boolean): IStringColumnOperation;
    function IsFixedLength: IStringColumnOperation;
    function IsMaxLength: IStringColumnOperation;
    function IsOptional: IStringColumnOperation;
    function IsRequired: IStringColumnOperation;
    function IsVariableLength: IStringColumnOperation;
    property Collation: string read GetCollation;
    property FixedLength: Boolean read GetFixedLength;
    property MaxLength: Boolean read GetMaxLength;
    property Unicode: Boolean read GetUnicode;
  end;

implementation

{ TStringColumnOperation }

constructor TStringColumnOperation.Create(const AName: string);
begin
  inherited Create(AName);
  HasMaxLength(0);
  IsVariableLength;
end;

function TStringColumnOperation.GetCollation: string;
begin
  Result := FCollation;
end;

function TStringColumnOperation.GetFixedLength: Boolean;
begin
  Result := FFixedLength;
end;

function TStringColumnOperation.GetMaxLength: Boolean;
begin
  Result := FMaxLength;
end;

function TStringColumnOperation.GetUnicode: Boolean;
begin
  Result := FUnicode;
end;

function TStringColumnOperation.HasCollation(const ACollation: string): IStringColumnOperation;
begin
  FCollation := ACollation;
  Result := Self;
end;

function TStringColumnOperation.HasColumnType(const AColumnType: string): IStringColumnOperation;
begin
  Result := TStringColumnOperation(inherited HasColumnType(AColumnType));
end;

function TStringColumnOperation.HasDefaultValueSql(const ADefaultValueSql: string): IStringColumnOperation;
begin
  Result := TStringColumnOperation(inherited HasDefaultValueSql(ADefaultValueSql));
end;

function TStringColumnOperation.HasMaxLength(const ALength: Integer): IStringColumnOperation;
begin
  FMaxLength := 1 > ALength;
  Result := TStringColumnOperation(inherited HasMaxLength(ALength));
end;

function TStringColumnOperation.HasSchema(const ASchema: string): IStringColumnOperation;
begin
  Result := TStringColumnOperation(inherited HasSchema(ASchema));
end;

function TStringColumnOperation.HasTable(const ATable: string): IStringColumnOperation;
begin
  Result := TStringColumnOperation(inherited HasTable(ATable));
end;

function TStringColumnOperation.HasUnicode(const AUnicode: Boolean): IStringColumnOperation;
begin
  FUnicode := AUnicode;
  Result := Self;
end;

function TStringColumnOperation.IsFixedLength: IStringColumnOperation;
begin
  FFixedLength := True;
  Result := Self;
end;

function TStringColumnOperation.IsMaxLength: IStringColumnOperation;
begin
  HasMaxLength(0);
  Result := Self;
end;

function TStringColumnOperation.IsOptional: IStringColumnOperation;
begin
  Result := TStringColumnOperation(inherited IsOptional);
end;

function TStringColumnOperation.IsRequired: IStringColumnOperation;
begin
  Result := TStringColumnOperation(inherited IsRequired);
end;

function TStringColumnOperation.IsVariableLength: IStringColumnOperation;
begin
  FFixedLength := False;
  Result := Self;
end;

end.
