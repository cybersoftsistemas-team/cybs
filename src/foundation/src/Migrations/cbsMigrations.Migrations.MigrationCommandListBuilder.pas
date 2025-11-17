unit cbsMigrations.Migrations.MigrationCommandListBuilder;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.CommandBuilder,
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder;

type
  TMigrationCommandListBuilder = class(TInterfacedObject, IMigrationCommandListBuilder)
  private
    FCommandList: ICommandList;
    FCommandBuilder: ICommandBuilder;
  public
    constructor Create;
    destructor Destroy; override;
    function Append(const AValue: string): IMigrationCommandListBuilder;
    function AppendCommands(const AMigrationCommands: IMigrationCommands): IMigrationCommandListBuilder;
    function AppendLine: IMigrationCommandListBuilder; overload;
    function AppendLine(const AValue: string): IMigrationCommandListBuilder; overload;
    function CommandList: IMigrationCommands;
    function EndCommand: IMigrationCommandListBuilder;
  end;

implementation

uses
{PROJECT}
  cbsMigrations.Migrations.CommandBuilder,
  cbsMigrations.Migrations.MigrationCommand;

{ TMigrationCommandListBuilder }

constructor TMigrationCommandListBuilder.Create;
begin
  inherited Create;
  FCommandList := CreateCommandList;
  FCommandBuilder := TCommandBuilder.Create;
end;

destructor TMigrationCommandListBuilder.Destroy;
begin
  FCommandList.Clear;
  FCommandList := nil;
  inherited;
end;

function TMigrationCommandListBuilder.CommandList: IMigrationCommands;
begin
  Result := FCommandList;
end;

function TMigrationCommandListBuilder.Append(const AValue: string): IMigrationCommandListBuilder;
begin
  FCommandBuilder.Append(AValue);
  Result := Self;
end;

function TMigrationCommandListBuilder.AppendLine: IMigrationCommandListBuilder;
begin
  FCommandBuilder.AppendLine;
  Result := Self;
end;

function TMigrationCommandListBuilder.AppendCommands(
  const AMigrationCommands: IMigrationCommands): IMigrationCommandListBuilder;
begin
  if not AMigrationCommands.IsEmpty then
  begin
    FCommandList.AddRange(AMigrationCommands);
  end;
end;

function TMigrationCommandListBuilder.AppendLine(const AValue: string): IMigrationCommandListBuilder;
begin
  FCommandBuilder.AppendLine(AValue);
  Result := Self;
end;

function TMigrationCommandListBuilder.EndCommand: IMigrationCommandListBuilder;
begin
  if not(FCommandBuilder.CommandTextLength = 0) then
  begin
    FCommandList.Add(
      TMigrationCommand.Create(
        FCommandBuilder.Build
      ));
    FCommandBuilder := nil;
    FCommandBuilder := TCommandBuilder.Create;
  end;
  Result := Self;
end;

end.
