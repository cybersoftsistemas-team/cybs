unit cbsServer.Database;

interface

uses
{PROJECT}
  cbsSystem.Database;

type
  TDatabase = class(TcbsDatabase)
  protected
    procedure BeforeExecuteMigrations; override;
    procedure OnExecuteMigrations; override;
  end;

implementation

uses
{PROJECT}
  cbsMain.inf.DbContext,
  cbsMain.inf.DbModule,
  cbsMain.support.RegisterMigrations,
  cbsSystem.Support.Migrations.Execute;

{ TDatabase }

procedure TDatabase.BeforeExecuteMigrations;
begin
  inherited;
  RegisterMigrations;
end;

procedure TDatabase.OnExecuteMigrations;
begin
  inherited;
  InternalExecuteMigrations(TdamDb, TDbContext);
end;

end.
