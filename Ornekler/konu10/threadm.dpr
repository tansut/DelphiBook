program threadm;

uses
  Forms,
  Uthreadm in 'Uthreadm.pas' {Form1},
  ucntthread in 'ucntthread.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
