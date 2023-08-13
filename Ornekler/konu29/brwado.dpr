program brwado;

uses
  Forms,
  ubrwado in 'ubrwado.pas' {FmMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
