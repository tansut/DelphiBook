program screenprj;

uses
  Forms,
  Uscreen in 'Uscreen.pas' {Form1},
  uscreen2 in 'uscreen2.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
