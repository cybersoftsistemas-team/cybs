unit cbsServer.Module.Api;

interface

type
  TcbsModuleVersion = record
    Major: Word;
    Minor: Word;
  end;

  TcbsModuleInfo = record
    Category: array[0..63] of AnsiChar;
    DisplayName: array[0..127] of AnsiChar;
    ModuleName: array[0..63] of AnsiChar;
    Version: TcbsModuleVersion;
  end;

  PModuleInfo = ^TcbsModuleInfo;

  TGetModuleInfo = function: PModuleInfo; {$IFDEF MSWINDOWS} stdcall {$ELSE} cdecl {$ENDIF};

  function GetModuleExtension: AnsiString;

implementation

function GetModuleExtension: AnsiString;
begin
{$IFDEF MSWINDOWS}
  Result := '.dll';
{$ELSEIF Defined(MACOS)}
  Result := '.dylib';
{$ELSEIF Defined(LINUX)}
  Result := '.so';
{$ELSE}
  Result := ''; // Caso improvável
{$ENDIF}
end;

end.
