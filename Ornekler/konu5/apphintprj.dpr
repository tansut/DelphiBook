program apphintprj;

uses
  Forms,
  Uapphint in 'Uapphint.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
