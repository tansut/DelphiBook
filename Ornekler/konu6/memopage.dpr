program memopage;

uses
  Forms,
  Umemopage in 'Umemopage.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
