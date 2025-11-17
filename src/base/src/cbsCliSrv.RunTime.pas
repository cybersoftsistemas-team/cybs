unit cbsCliSrv.RunTime;

interface

type
  RunTime = class
  private
    class var FIsElectron: Boolean;
  public
    class property IsElectron: Boolean read FIsElectron write FIsElectron;
  end;

implementation

end.
