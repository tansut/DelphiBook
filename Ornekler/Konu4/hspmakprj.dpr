program hspmakprj;

uses
  Forms,
  Uhspmak in 'Uhspmak.pas' {Form1},
  hspmak in 'hspmak.pas',
  bhspmak in 'bhspmak.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
