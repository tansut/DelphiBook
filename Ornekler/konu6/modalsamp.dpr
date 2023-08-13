program modalsamp;

uses
  Forms,
  Umodsampmain in 'Umodsampmain.pas' {Form1},
  umodsamp in 'umodsamp.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
