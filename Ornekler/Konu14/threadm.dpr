program threadm;

uses
  SvcMgr,
  UMain in 'UMain.pas' {DTTelnetServer: TService};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDTTelnetServer, DTTelnetServer);
  Application.Run;
end.
