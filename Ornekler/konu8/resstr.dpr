program resstr;

uses
  Forms,
  Uresstr in 'Uresstr.pas' {Form1};

{$R *.RES}
{$R all.res}
begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
