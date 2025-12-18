unit cbsSystem.Support.RuntimePackages.Detector;

interface

type
  RuntimePackageDetector = class
  public
    class function GetRuntimePackages: TArray<string>; static;
    class function IsRuntimePackage(const AFileName: string): Boolean; static;
  end;

implementation

uses
{IDE}
  System.StrUtils,
  System.SysUtils;

const
  InternalRuntimePackages: TArray<string> = [
    'cbsMain.bpl',
    'cbsMigrations.bpl',
    'cbsMigrationsFireDAC.bpl',
    'cbsSystem.bpl'
  ];

class function RuntimePackageDetector.GetRuntimePackages: TArray<string>;
begin
  Result := InternalRuntimePackages;
end;

class function RuntimePackageDetector.IsRuntimePackage(const AFileName: string): Boolean;
begin
  GetRuntimePackages;
  var LName := ExtractFileName(AFileName).ToLower;
  Result := MatchText(LName, InternalRuntimePackages);
end;

end.
