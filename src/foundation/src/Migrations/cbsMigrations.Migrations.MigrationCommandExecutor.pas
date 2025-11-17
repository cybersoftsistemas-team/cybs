unit cbsMigrations.Migrations.MigrationCommandExecutor;

interface

uses
{PROJECT}
  cbsMigrations.Contracts.Migrations.ConnectionResolver,
  cbsMigrations.Contracts.Migrations.MigrationCommandExecutor,
  cbsMigrations.Contracts.Migrations.MigrationCommandListBuilder;

type
  TMigrationCommandExecutor = class(TInterfacedObject, IMigrationCommandExecutor)
  private
    FResolver: IConnectionResolver;
  protected
    property Resolver: IConnectionResolver read FResolver;
  public
    constructor Create(const AResolver: IConnectionResolver);
    destructor Destroy; override;
    procedure ExecuteNonQuery(const AMigrationCommands: IMigrationCommands); virtual; abstract;
  end;

implementation

{ TMigrationCommandExecutor }

constructor TMigrationCommandExecutor.Create(const AResolver: IConnectionResolver);
begin
  inherited Create;
  FResolver := AResolver;
end;

destructor TMigrationCommandExecutor.Destroy;
begin
  FResolver := nil;
  inherited;
end;

end.
