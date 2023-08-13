program swhintprj;

uses
  Forms,
  Uswhint in 'Uswhint.pas' {FmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
