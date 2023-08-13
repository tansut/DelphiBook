program dsupport;

uses
  Forms,
  Umain in 'Umain.pas' {FmMain},
  ugraph in 'ugraph.pas' {FmGraph};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
