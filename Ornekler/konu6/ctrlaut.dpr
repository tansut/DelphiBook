program ctrlaut;

uses
  Forms,
  Uctrlaut in 'Uctrlaut.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
