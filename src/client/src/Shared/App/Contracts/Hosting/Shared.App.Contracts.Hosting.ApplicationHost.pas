unit Shared.App.Contracts.Hosting.ApplicationHost;

interface

type
  IApplicationHost = interface(IUnknown)
    ['{ABEC7B57-D458-4A59-AB51-D57D58D31FD9}']
    procedure Listen(const APort: Integer);
  end;

implementation

end.
