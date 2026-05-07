unit cbsMain.inf.DbSeedModule;

interface

uses
{PROJTECT}
  cbsSystem.Database.Seeders.DatabaseSeederModule,
{IDE}
  FireDAC.UI.Intf, FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, System.Classes, FireDAC.Stan.Intf, FireDAC.Comp.Script;

type
  TdamDbSeed = class(TDatabaseSeederModule)
  protected
    procedure BeforeRunSeed; override;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
{IDE}
  System.SysUtils,
{PROJTECT}
  cbsUAuth.dom.General.Common.SystemEmails;

{ TdamDbSeed }

procedure TdamDbSeed.BeforeRunSeed;
begin
  inherited;
  sptSeed.Params.ParamByName('CountryId').AsGuid := StringToGUID('{46A7433E-F36B-1410-871D-007892B87384}');
  // General Emails...
  sptSeed.Params.ParamByName('ElsEmailsId').AsGuid := TSystemEmails.ElsEmailsIdId;
  sptSeed.Params.ParamByName('ElsEmailId').AsGuid := TSystemEmails.ElsEmailIdId;
  sptSeed.Params.ParamByName('ElsEmail2Id').AsGuid := TSystemEmails.ElsEmail2IdId;
  sptSeed.Params.ParamByName('ElsOtherId').AsGuid := TSystemEmails.ElsOtherIdId;
end;

end.
