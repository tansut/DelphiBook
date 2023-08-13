program ctrlalign;

uses
  Forms,
  Uctrlalgn in 'Uctrlalgn.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
