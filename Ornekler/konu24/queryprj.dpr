program queryprj;

uses
  Forms,
  Uqueryprj in 'Uqueryprj.pas' {FmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
