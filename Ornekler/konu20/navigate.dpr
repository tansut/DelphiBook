program navigate;

uses
  Forms,
  Unav in 'Unav.pas' {Form1},
  Unavdm in 'Unavdm.pas' {DMNav: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDMNav, DMNav);
  Application.Run;
end.
