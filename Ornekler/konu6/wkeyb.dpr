program wkeyb;

uses
  Forms,
  Uwkeyb in 'Uwkeyb.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
