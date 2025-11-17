unit cbsMigrations.Migrations.CommandBuilder;

interface

uses
{IDE}
  System.SysUtils,
{PROJECT}
  cbsMigrations.Contracts.Migrations.CommandBuilder;

type
  TCommandBuilder = class(TInterfacedObject, ICommandBuilder)
  private
    FCommandBuilder: TStringBuilder;
  public
    constructor Create;
    destructor Destroy; override;
    function CommandTextLength: Integer;
    function Append(const AValue: string): ICommandBuilder;
    function AppendLine: ICommandBuilder; overload;
    function AppendLine(const AValue: string): ICommandBuilder; overload;
    function Build: TCommandText;
  end;

implementation

{ TCommandBuilder }

constructor TCommandBuilder.Create;
begin
  inherited Create;
  FCommandBuilder := TStringBuilder.Create;
end;

destructor TCommandBuilder.Destroy;
begin
  FreeAndNil(FCommandBuilder);
  inherited;
end;

function TCommandBuilder.CommandTextLength: Integer;
begin
  Result := FCommandBuilder.Length;
end;

function TCommandBuilder.Append(const AValue: string): ICommandBuilder;
begin
  FCommandBuilder.Append(AValue);
  Result := Self;
end;

function TCommandBuilder.AppendLine: ICommandBuilder;
begin
  FCommandBuilder.AppendLine;
  Result := Self;
end;

function TCommandBuilder.AppendLine(const AValue: string): ICommandBuilder;
begin
  FCommandBuilder.AppendLine(AValue);
  Result := Self;
end;

function TCommandBuilder.Build: TCommandText;
begin
  Result := FCommandBuilder.ToString;
end;

end.
