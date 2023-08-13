program tvchange;

uses
  Forms,
  Utvchange in 'Utvchange.pas' {FmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
