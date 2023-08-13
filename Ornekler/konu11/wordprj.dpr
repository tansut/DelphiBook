program wordprj;

uses
  Forms,
  Uwordprj in 'Uwordprj.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
